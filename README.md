
# PostgreSQL UDF Example

This repository contains an example of a C User-Defined Function (UDF) for PostgreSQL. The UDF takes a string as input and returns a string as output.

## Description

- `string_udf.c`: The C source file for the UDF.
- `Makefile`: The makefile to compile the UDF into a shared library.
- `string_udf--1.0.sql`: The SQL script to create the UDF in PostgreSQL.
- `string_udf.control`: The control file for the PostgreSQL extension.
- `Dockerfile`: The Dockerfile to build an image with PostgreSQL and compile the UDF.

## Instructions to Compile and Use the UDF

### Prerequisites

- PostgreSQL installed and running.
- GCC compiler and Make utility installed.

### Step 1: Compile the UDF

1. **Create the Shared Library:**
   Place `string_udf.c`, `Makefile`, `string_udf--1.0.sql`, and `string_udf.control` in the same directory. Run the following command to compile the UDF:
   ```sh
   make
   sudo make install
   ```

### Step 2: Load the UDF in PostgreSQL

1. **Connect to PostgreSQL Database:**
   Use `psql` or another PostgreSQL client to connect to your PostgreSQL database.

2. **Create the UDF:**
   Execute the following SQL command to create the UDF:
   ```sql
   CREATE EXTENSION string_udf;
   ```

### Step 3: Test the UDF

1. **Test the UDF:**
   Verify that your UDF is working by calling the function in SQL. Run:
   ```sql
   SELECT string_udf('Hello, World!');
   ```
   This should return `Hello, World!` if the UDF is functioning correctly.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
