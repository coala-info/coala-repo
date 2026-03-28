# fmsi CWL Generation Report

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


## Metadata
- **Skill**: generated
