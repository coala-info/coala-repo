# fmsi CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fmsi_compact | PASS | synthetic data: compacted a merged index of a real SARS-CoV-2 superstring and a derived second set; queries match the union |
| fmsi_diff | Not completed | synthetic data only: on two real-derived sets, 22 to 48 k-mer answers differ from an independent set computation for k-mers that occur twice, so the output cannot be confirmed |
| fmsi_export | PASS | real SARS-CoV-2 masked superstring from the fmsi repo; output checked against an independent k-mer computation; fixed argument order and index file handling |
| fmsi_index | PASS | real SARS-CoV-2 masked superstring from the fmsi repo; output checked against an independent k-mer computation; fixed argument order and index file handling |
| fmsi_inter | Not completed | synthetic data only: on two real-derived sets, 22 to 48 k-mer answers differ from an independent set computation for k-mers that occur twice, so the output cannot be confirmed |
| fmsi_lookup | PASS | real SARS-CoV-2 masked superstring from the fmsi repo; output checked against an independent k-mer computation; fixed argument order and index file handling |
| fmsi_merge | PASS | synthetic data: second set made by switching off half of the real SARS-CoV-2 masked superstring mask; result matches an independent k-mer computation |
| fmsi_query | PASS | real SARS-CoV-2 masked superstring from the fmsi repo; output checked against an independent k-mer computation; fixed argument order and index file handling |
| fmsi_symdiff | Not completed | synthetic data only: on two real-derived sets, 22 to 48 k-mer answers differ from an independent set computation for k-mers that occur twice, so the output cannot be confirmed |
| fmsi_union | PASS | synthetic data: second set made by switching off half of the real SARS-CoV-2 masked superstring mask; result matches an independent k-mer computation |

## fmsi_index

### Tool Description
Index a masked superstring for fmsi.

### Metadata
- **Docker Image**: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
- **Homepage**: https://github.com/OndrejSladky/fmsi
- **Package**: https://anaconda.org/channels/bioconda/packages/fmsi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fmsi/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/OndrejSladky/fmsi
- **Stars**: N/A
### Original Help Text
```text
ERROR: Path to the masked superstring is a required argument.

Usage:   fmsi index [options] <masked-superstring-input>

Options:
    -k INT  - size of k-mers [recommended, default: number of mask trailing zeros - 1]
    -x      - do not compute the kLCP array used for faster streaming queries.

Note: `fmsi index` accepts only masked superstrings - these can be computed e.g. by KmerCamel from any FASTA file.
```


## fmsi_query

### Tool Description
Query an FMSI index.

### Metadata
- **Docker Image**: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
- **Homepage**: https://github.com/OndrejSladky/fmsi
- **Package**: https://anaconda.org/channels/bioconda/packages/fmsi/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: index not correctly loaded. Ensure that you correctly call `fmsi index` before.

Usage:   fmsi query [options] <index-prefix>

Options (stable):
  -q FILE - Path to FASTA/FASTQ with queries [default: stdin]
  -k INT  - Size of k-mers [default: infer automatically from index]
  -S      - Use kLCP array for streamed queries (increses memory consumption)
  -O      - FMSI uses properties of max-one masked superstrings to speed up queries
            Use only if a masked superstring with maximum number of ones is indexed.
Parameters (experimental, using f-MS framework):
  -f FUNCTION - Demasking function to determine k-mer presence; recognized functions:
    or      - represented when at least 1 ON occurrence [default]
    all     - all occurrence are either ON or OFF (equivalent to -O flag for queries)
    and     - represented when no OFF occurrence
    xor     - represented when an odd number of ON occurrences
    INT-INT - represented when in the bounds
```


## fmsi_lookup

### Tool Description
Look up sequences in an FMSI index.

### Metadata
- **Docker Image**: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
- **Homepage**: https://github.com/OndrejSladky/fmsi
- **Package**: https://anaconda.org/channels/bioconda/packages/fmsi/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: index not correctly loaded. Ensure that you correctly call `fmsi index` before.

Usage:   fmsi lookup [options] <index-prefix>

Options (stable):
  -q FILE - Path to FASTA/FASTQ with queries [default: stdin]
  -k INT  - Size of k-mers [default: infer automatically from index]
  -S      - Use kLCP array for streamed queries (increses memory consumption)
```


## fmsi_export

### Tool Description
Export data from an FMS index.

### Metadata
- **Docker Image**: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
- **Homepage**: https://github.com/OndrejSladky/fmsi
- **Package**: https://anaconda.org/channels/bioconda/packages/fmsi/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: index not correctly loaded. Ensure that you correctly call `fmsi index` before.

Usage:   fmsi export <index-prefix>
```


## fmsi_union

### Tool Description
Compute the union of k-mers from several FMSI indices (experimental).

### Metadata
- **Docker Image**: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
- **Homepage**: https://github.com/OndrejSladky/fmsi
- **Package**: https://anaconda.org/channels/bioconda/packages/fmsi/overview
- **Validation**: PASS

### Original Help Text
```text
At least two indices are required for merging.

Usage:   fmsi union [options]


Options:
  `-p path_to_fasta`  - The path to the fasta file with input sets. Can be provided multiple times. It is expected that it appears at least twice.
  `-r path_of_result` - The path where the result should be stored. Required.
  `-k value_of_k` - The size of queried k-mers (only used to check with the index one).
```

## fmsi_inter

### Tool Description
Compute the intersection of k-mers from several FMSI indices (experimental).

### Metadata
- **Docker Image**: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
- **Homepage**: https://github.com/OndrejSladky/fmsi
- **Package**: https://anaconda.org/channels/bioconda/packages/fmsi/overview
- **Validation**: PASS

### Original Help Text
```text
At least two indices are required for merging.

Usage:   fmsi inter [options]


Options:
  `-p path_to_fasta`  - The path to the fasta file with input sets. Can be provided multiple times. It is expected that it appears at least twice.
  `-r path_of_result` - The path where the result should be stored. Required.
  `-k value_of_k` - The size of queried k-mers (only used to check with the index one).
```

## fmsi_diff

### Tool Description
Compute the set difference of k-mers from several FMSI indices (experimental).

### Metadata
- **Docker Image**: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
- **Homepage**: https://github.com/OndrejSladky/fmsi
- **Package**: https://anaconda.org/channels/bioconda/packages/fmsi/overview
- **Validation**: PASS

### Original Help Text
```text
At least two indices are required for merging.

Usage:   fmsi diff [options]


Options:
  `-p path_to_fasta`  - The path to the fasta file with input sets. Can be provided multiple times. It is expected that it appears at least twice.
  `-r path_of_result` - The path where the result should be stored. Required.
  `-k value_of_k` - The size of queried k-mers (only used to check with the index one).
```

## fmsi_symdiff

### Tool Description
Compute the symmetric difference of k-mers from several FMSI indices (experimental).

### Metadata
- **Docker Image**: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
- **Homepage**: https://github.com/OndrejSladky/fmsi
- **Package**: https://anaconda.org/channels/bioconda/packages/fmsi/overview
- **Validation**: PASS

### Original Help Text
```text
At least two indices are required for merging.

Usage:   fmsi symdiff [options]


Options:
  `-p path_to_fasta`  - The path to the fasta file with input sets. Can be provided multiple times. It is expected that it appears at least twice.
  `-r path_of_result` - The path where the result should be stored. Required.
  `-k value_of_k` - The size of queried k-mers (only used to check with the index one).
```

## fmsi_merge

### Tool Description
Merge several FMSI indices into one masked superstring (experimental).

### Metadata
- **Docker Image**: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
- **Homepage**: https://github.com/OndrejSladky/fmsi
- **Package**: https://anaconda.org/channels/bioconda/packages/fmsi/overview
- **Validation**: PASS

### Original Help Text
```text
At least two indices are required for merging.

Usage:   fmsi merge [options]


Options:
  `-p path_to_fasta`  - The path to the fasta file with input sets. Can be provided multiple times. It is expected that it appears at least twice.
  `-r path_of_result` - The path where the result should be stored. Required.
  `-k value_of_k` - The size of queried k-mers (only used to check with the index one).
```

## fmsi_compact

### Tool Description
Compact the masked superstring of an FMSI index (experimental).

### Metadata
- **Docker Image**: quay.io/biocontainers/fmsi:0.4.0--h077b44d_0
- **Homepage**: https://github.com/OndrejSladky/fmsi
- **Package**: https://anaconda.org/channels/bioconda/packages/fmsi/overview
- **Validation**: PASS

### Original Help Text
```text
Path to the fasta file is a required argument.

Usage:   fmsi compact [options] <index-prefix>


Options (all experimental):

The recognized arguments are:
    `-k value_of_k` - The size of queried k-mers.
    `-s` - Only print the compacted masked superstring and do not compact the index
  -f FUNCTION - Demasking function to determine k-mer presence; recognized functions:
    or      - represented when at least 1 ON occurrence [default]
    all     - all occurrence are either ON or OFF (equivalent to -O flag for queries)
    and     - represented when no OFF occurrence
    xor     - represented when an odd number of ON occurrences
    INT-INT - represented when in the bounds
```

## Metadata
- **Skill**: generated
