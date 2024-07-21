
FROM postgres:13

RUN apt-get update && apt-get install -y \
    build-essential \
    postgresql-server-dev-13

USER postgres

# Copy UDF source and makefile into the container
COPY string_udf.c /usr/local/src/
COPY Makefile /usr/local/src/
COPY string_udf--1.0.sql /usr/local/src/

# Set working directory
WORKDIR /usr/local/src

# Build the UDF
RUN make && make install

# Start the PostgreSQL server
CMD ["postgres"]
