---
name: bigsi
description: BIGSI indexes and searches k-mers across massive genomic datasets using bit-sliced Bloom filters. Use when user asks to build a genomic index, search for sequences or variants in large datasets, or insert and delete samples from an existing index.
homepage: https://github.com/Phelimb/BIGSI
---


# bigsi

## Overview

BIGSI (BItsliced Genomic Signature Index) is a specialized tool for the scalable indexing and searching of k-mers within massive datasets of genomic sequences. It transforms large collections of WGS data into a searchable index by using bit-sliced Bloom filters, allowing for near-instantaneous queries to determine which samples contain a specific sequence or variant. This is particularly useful for researchers performing large-scale comparative genomics or tracking the presence of specific genes (like antibiotic resistance genes) across global datasets.

## Common CLI Patterns and Usage

### Environment Configuration
BIGSI relies heavily on environment variables for configuration. Before running commands, ensure your storage backend and index parameters are defined.

```bash
# Set storage backend (berkeleydb or redis)
export STORAGE='berkeleydb'
export BDB_DB_FILENAME='my_genomic_index'

# Define Bloom filter parameters
export BFSIZE=1000000  # Size of the Bloom filter
export NUM_HASHES=3    # Number of hash functions
```

### Building an Index
The typical workflow involves initializing the database and then building the index from processed genomic data (usually Bloom filters or sequence files).

*   **Initialize the database**: Prepare the storage backend for indexing.
*   **Build the index**: Construct the bit-sliced index from a set of input samples.
    ```bash
    bigsi build --samples <sample_list> --out <index_name>
    ```

### Searching the Index
Search for specific k-mers or sequences across the entire indexed collection.

*   **Sequence Search**: Query a FASTA file or a raw string against the index.
    ```bash
    bigsi search <sequence_string>
    bigsi search --fasta <query.fasta>
    ```

### Managing Samples
You can update existing indices without a full rebuild.

*   **Insert**: Add new samples to an existing index.
    ```bash
    bigsi insert <sample_bloom_filter> --name <sample_name>
    ```
*   **Delete**: Remove a sample from the index.
    ```bash
    bigsi delete --name <sample_name>
    ```

## Expert Tips

*   **Storage Selection**: Use `berkeleydb` for local, single-machine tasks. For distributed environments or high-concurrency web services, use `redis`.
*   **Parameter Tuning**: The `BFSIZE` and `NUM_HASHES` must be consistent across all samples in an index. Increasing `BFSIZE` reduces the false-positive rate but increases the memory/disk footprint.
*   **Memory Mapping**: When using BerkeleyDB, ensure your filesystem has enough IOPS, as BIGSI performs many small reads during bit-slice lookups.
*   **Batch Processing**: When building large indices, it is more efficient to build Bloom filters for individual samples first and then use `bigsi build` to merge them into the bit-sliced format.



## Subcommands

| Command | Description |
|---------|-------------|
| bigsi build | Build a BIGSI index. |
| bigsi-v0.3.1 bloom | Creates a bloom filter from a sequence file or cortex graph. |
| bigsi-v0.3.1 insert | Inserts a bloom filter into the graph e.g. bigsi insert ERR1010211.bloom ERR1010211 |
| bigsi-v0.3.1 merge | (No description) |
| bigsi-v0.3.1 search | Search for a sequence |
| delete | Deletes a BigSI index. |

## Reference documentation
- [BIGSI README](./references/github_com_Phelimb_BIGSI_blob_master_README.md)
- [Dockerfile Configuration](./references/github_com_Phelimb_BIGSI_blob_master_Dockerfile.md)
- [Test Environment Variables](./references/github_com_Phelimb_BIGSI_blob_master_.env_test.md)