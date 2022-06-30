# build stage
FROM rust:1.61.0 AS builder

COPY ./build .
COPY ./hello_world ./hello_world
RUN apt-get update && xargs -a packages.txt -r apt-get install -y && rm -rf packages.txt /var/lib/apt/lists/*

WORKDIR ./hello_world
RUN cargo install --path .

# final stage
FROM enclaive/gramine-os:latest

COPY ./packages.txt .

RUN apt-get update && xargs -a packages.txt -r apt-get install -y && rm -rf packages.txt /var/lib/apt/lists/*

COPY --from=builder /hello_world/target/release/hello_world /app/
COPY ./rust.manifest.template /app/
COPY ./entrypoint.sh /app/

WORKDIR /app

RUN gramine-sgx-gen-private-key \
    && gramine-manifest -Dlog_level=error -Darch_libdir=/lib/x86_64-linux-gnu rust.manifest.template rust.manifest \
    && gramine-sgx-sign --manifest rust.manifest --output rust.manifest.sgx

ENTRYPOINT ["sh", "entrypoint.sh"]