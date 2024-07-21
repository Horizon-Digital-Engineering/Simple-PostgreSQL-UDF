FROM postgres:13

# Install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    postgresql-server-dev-13

# Create a directory for the source files with the necessary permissions
RUN mkdir -p /usr/local/src/udf

# Copy UDF source and makefile into the container
COPY string_udf.c /usr/local/src/udf/
COPY Makefile /usr/local/src/udf/
COPY string_udf--1.0.sql /usr/local/src/udf/

# Change ownership to the postgres user
RUN chown -R postgres:postgres /usr/local/src/udf

# Switch to user postgres to avoid permission issues
USER postgres

# Set working directory
WORKDIR /usr/local/src/udf

# Build the UDF
RUN make && make install

# Start the PostgreSQL server
CMD ["postgres"]
