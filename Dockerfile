# Use the official Debian-based PostgreSQL image as a base
FROM postgres:17.4 AS builder

# Install dependencies for building extensions
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    uuid-dev \
    postgresql-server-dev-17 \
    ca-certificates

# Clone and build the pg_uuidv7 extension
WORKDIR /usr/src
RUN git clone --depth 1 https://github.com/fboulnois/pg_uuidv7.git && \
    cd pg_uuidv7 && \
    make && \
    make install

# Create final image with minimal footprint
FROM postgres:17.4

# Copy only the compiled extension files from the builder stage
COPY --from=builder /usr/lib/postgresql/17/lib/pg_uuidv7.so /usr/lib/postgresql/17/lib/
COPY --from=builder /usr/share/postgresql/17/extension/pg_uuidv7* /usr/share/postgresql/17/extension/

# Set the default command back to the original PostgreSQL entrypoint
CMD ["postgres"]