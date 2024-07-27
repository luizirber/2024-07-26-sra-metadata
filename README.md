# Prepare a subset from SRA metadata using duckdb

The instructions for accessing [the SRA metadata in the cloud](https://www.ncbi.nlm.nih.gov/sra/docs/sra-athena/)
show a command to list the contents of a bucket containing the tables:

```
aws s3 ls s3://sra-pub-metadata-us-east-1/sra/metadata/ --no-sign-request
```

These tables are parquet files,
and instead of using Athena to query it this repo has a SQL script
for `duckdb` to do a similar query locally,
and save results to a `subset.parquet` file for later use.

## Steps

### Install pixi

```bash
curl -fsSL https://pixi.sh/install.sh | bash
```

### Prepare duckdb

`duckdb` in conda-forge is missing the [parquet extension](https://github.com/conda-forge/duckdb-split-feedstock/issues/9)
but it can be installed with
```
pixi run install_parquet
```

### Download data

```bash
pixi run download
```
This will download around 9GiB of data (as of 2024-07-26)

### Subset data

```bash
pixi run subset
```

This executes the `query.sql` file in `duckdb`,
in my laptop this took a bit more than 17 minutes on HDD,
and 4m30s on SSD.
Final parquet file is `subset.parquet`
