
# PostgreSQL UDF Example

This repository contains an example of a C User-Defined Function (UDF) for PostgreSQL. The UDF takes a string as input and returns a string as output.

## Description

- `string_udf.c`: The C source file for the UDF.
- `Makefile`: The makefile to compile the UDF into a shared library.
- `string_udf--1.0.sql`: The SQL script to create the UDF in PostgreSQL.
- `string_udf.control`: The control file for the PostgreSQL extension.
- `Dockerfile`: The Dockerfile to build an image with PostgreSQL and compile the UDF.
- `.github/workflows/test-udf.yml`: The GitHub Actions workflow to automate testing of the UDF.

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

## Automated Testing with GitHub Actions

The repository includes a GitHub Actions workflow to automate testing of the UDF using Docker.

### Step 1: Create Dockerfile

Ensure you have the `Dockerfile` to build an image with PostgreSQL and required tools to compile your UDF.

### Step 2: Create GitHub Actions Workflow

Ensure you have the `.github/workflows/test-udf.yml` file to define the GitHub Actions workflow.

### GitHub Actions Workflow File

```yaml
name: Test PostgreSQL UDF

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Set up Docker
        run: docker build -t postgres-udf-test .

      - name: Run PostgreSQL UDF Test
        run: |
          # Ensure any previous container is removed
          docker rm -f postgres-test || true

          # Run the new container with the password
          docker run -d --name postgres-test -e POSTGRES_PASSWORD=example postgres-udf-test

          # Wait for PostgreSQL to initialize
          sleep 60

          # Check container logs for troubleshooting
          docker logs postgres-test

          # Check PostgreSQL is ready
          until docker exec -u postgres postgres-test pg_isready; do
            sleep 5
          done

          # Run the extension creation and test commands
          docker exec -u postgres postgres-test psql -U postgres -c "CREATE EXTENSION string_udf;"
          docker exec -u postgres postgres-test psql -U postgres -c "SELECT string_udf('Hello, World!');"
```

### Step 3: Push Your Changes

Push the necessary files to your GitHub repository:
- `string_udf.c`
- `Makefile`
- `string_udf--1.0.sql`
- `string_udf.control`
- `Dockerfile`
- `.github/workflows/test-udf.yml`

### Step 4: Monitor the Workflow

Once you push the changes, GitHub Actions will automatically run the workflow to build and test the UDF. You can monitor the progress and results in the "Actions" tab of your GitHub repository.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
