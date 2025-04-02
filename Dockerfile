# Use the official Debian-based PostgreSQL image as a base
FROM postgres:17.4

# Install dependencies for building extensions and CA certificates
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    uuid-dev \
    autoconf \
    automake \
    cmake \
    make \
    gcc \
    libc6-dev \
    ca-certificates \
    wget \
    curl \
    gnupg2 \
    postgresql-server-dev-17 && \
    # Update CA certificates
    update-ca-certificates && \
    # Clone a more reliable pg_uuidv7 repository
    cd /usr/src && \
    git clone https://github.com/fboulnois/pg_uuidv7.git && \
    cd pg_uuidv7 && \
    # Build and install the extension
    make && \
    make install && \
    # Clean up unnecessary files to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/src/pg_uuidv7/*

# Set the default command back to the original PostgreSQL entrypoint
CMD ["postgres"]