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
# Specifes subdirectory in /entrypoint/ for web files, e.g. *.html, *.js, ...
ARG webFiles

COPY ./packages.txt .
RUN apt-get update && xargs -a packages.txt -r apt-get install -y && rm -rf packages.txt /var/lib/apt/lists/*

# Copy executable
COPY --from=builder /$projectName/target/release/$projectName /entrypoint/app
# Copy web files
COPY ./$webFiles/ /entrypoint/$webFiles/
# Copy required files
COPY ./rust.manifest.template /manifest/
COPY ./entrypoint.sh /entrypoint/

WORKDIR /entrypoint/

RUN /manifest/manifest.sh rust

EXPOSE 80

ENTRYPOINT [ "/entrypoint/enclaive.sh", "rust" ]