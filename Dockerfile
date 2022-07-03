# Specifes name of the project and executable
ARG projectName

# build stage
FROM rust:1.61.0 AS builder
ARG projectName

COPY ./build .
COPY ./$projectName/ ./$projectName/
RUN apt-get update && xargs -a packages.txt -r apt-get install -y && rm -rf packages.txt /var/lib/apt/lists/*

# Compile executable in release mode
RUN cargo install --path ./$projectName/

# final stage
FROM enclaive/gramine-os:latest
ARG projectName
# Specifes subdirectory in /app/ for web files, e.g. *.html, *.js, ...
ARG webFiles

COPY ./packages.txt .
RUN apt-get update && xargs -a packages.txt -r apt-get install -y && rm -rf packages.txt /var/lib/apt/lists/*

# Copy executable
COPY --from=builder /$projectName/target/release/$projectName /app/
# Copy web files
COPY ./$webFiles/ /app/$webFiles/
# Copy required files
COPY ./rust.manifest.template /app/
COPY ./entrypoint.sh /app/

WORKDIR /app/

RUN gramine-sgx-gen-private-key \
    && gramine-manifest -Dlog_level=error -Darch_libdir=/lib/x86_64-linux-gnu rust.manifest.template rust.manifest -Dexecutable=$projectName \
    && gramine-sgx-sign --manifest rust.manifest --output rust.manifest.sgx

EXPOSE 80

ENTRYPOINT ["sh", "entrypoint.sh"]