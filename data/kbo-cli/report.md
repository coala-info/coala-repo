# kbo-cli CWL Generation Report

## kbo-cli_kbo

### Tool Description
kbo

### Metadata
- **Docker Image**: quay.io/biocontainers/kbo-cli:0.2.1--h4349ce8_0
- **Homepage**: https://docs.rs/kbo
- **Package**: https://anaconda.org/channels/bioconda/packages/kbo-cli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kbo-cli/overview
- **Total Downloads**: 543
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tmaklin/kbo-cli
- **Stars**: N/A
### Original Help Text
```text
Usage: kbo [COMMAND]

Commands:
  build  
  call   
  find   
  map    
  help   Print this message or the help of the given subcommand(s)

Options:
  -h, --help     Print help
  -V, --version  Print version
```


## kbo-cli_kbo call

### Tool Description
Call variants using k-mer based approach.

### Metadata
- **Docker Image**: quay.io/biocontainers/kbo-cli:0.2.1--h4349ce8_0
- **Homepage**: https://docs.rs/kbo
- **Package**: https://anaconda.org/channels/bioconda/packages/kbo-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kbo call [OPTIONS] --reference <REF_FILE> <QUERY_FILE>

Arguments:
  <QUERY_FILE>  Query file with sequence data.

Options:
  -t, --threads <NUM_THREADS>  [default: 1]
      --verbose                
  -h, --help                   Print help
  -V, --version                Print version

Input:
  -r, --reference <REF_FILE>  Reference sequence to call variants in.

Output:
  -o, --output <OUTPUT_FILE>  Write output to a file instead of printing.

Algorithm:
      --max-error-prob <MAX_ERROR_PROB>
          Tolerance for errors in k-mer matching. [default: 0.00000001]

Build options:
  -k <KMER_SIZE>
          k-mer size, larger values are slower and use more space. [default: 51]
  -p, --prefix-precalc <PREFIX_PRECALC>
          Length of precalculated prefixes included in the index. [default: 8]
  -d, --dedup-batches
          Deduplicate k-mer batches to save some memory.
```


## kbo-cli_kbo find

### Tool Description
Finds sequences in query files based on a reference or index.

### Metadata
- **Docker Image**: quay.io/biocontainers/kbo-cli:0.2.1--h4349ce8_0
- **Homepage**: https://docs.rs/kbo
- **Package**: https://anaconda.org/channels/bioconda/packages/kbo-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kbo find [OPTIONS] --input-list <INPUT_LIST> <QUERY_FILES>...

Arguments:
  <QUERY_FILES>...  Query file(s) with sequence data.

Options:
  -t, --threads <NUM_THREADS>  [default: 1]
      --verbose                
  -h, --help                   Print help
  -V, --version                Print version

Input:
  -l, --input-list <INPUT_LIST>  File with paths or tab separated name and path on each line.
  -r, --reference <REF_FILE>     File with target sequence data (excludes -i).
  -i, --index <INDEX_PREFIX>     Prefix for prebuilt <prefix>.sbwt and <prefix>.lcs (excludes -r).
      --detailed                 

Output:
  -o, --output <OUTPUT_FILE>  Write output to a file instead of printing.

Algorithm:
      --min-len <MIN_LEN>                Minimum alignment length to report. [default: 100]
      --max-gap-len <MAX_GAP_LEN>        Allow gaps of this length in the alignment. [default: 0]
      --max-error-prob <MAX_ERROR_PROB>  Tolerance for errors in k-mer matching. [default: 0.0000001]

Build options:
  -k <KMER_SIZE>
          k-mer size, larger values are slower and use more space. [default: 31]
  -p, --prefix-precalc <PREFIX_PRECALC>
          Length of precalculated prefixes included in the index. [default: 8]
  -d, --dedup-batches
          Deduplicate k-mer batches to save some memory.
  -m, --mem-gb <MEM_GB>
          Memory available when building on temp disk space (in gigabytes). [default: 4]
      --temp-dir <TEMP_DIR>
          Build on temporary disk space at this path instead of in-memory.
```


## kbo-cli_kbo map

### Tool Description
Map sequence data against a reference.

### Metadata
- **Docker Image**: quay.io/biocontainers/kbo-cli:0.2.1--h4349ce8_0
- **Homepage**: https://docs.rs/kbo
- **Package**: https://anaconda.org/channels/bioconda/packages/kbo-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kbo map [OPTIONS] --input-list <INPUT_LIST> --reference <REF_FILE> <QUERY_FILES>...

Arguments:
  <QUERY_FILES>...  Sequence data file(s).

Options:
  -t, --threads <NUM_THREADS>  [default: 1]
      --verbose                
  -h, --help                   Print help
  -V, --version                Print version

Input:
  -l, --input-list <INPUT_LIST>  File with paths or tab separated name and path on each line.
  -r, --reference <REF_FILE>     Reference sequence to map against.

Output:
  -o, --output <OUTPUT_FILE>  Write output to a file instead of printing.
      --raw                   Output the internal representation instead of an alignment.

Algorithm:
      --max-error-prob <MAX_ERROR_PROB>  Tolerance for errors in k-mer matching. [default: 0.0000001]
      --no-gap-filling                   Skip running the gap filling algorithm.
      --no-variant-calling               Skip using variant calling to improve the alignment.

Build options:
  -k <KMER_SIZE>
          k-mer size, larger values are slower and use more space. [default: 31]
  -p, --prefix-precalc <PREFIX_PRECALC>
          Length of precalculated prefixes included in the index. [default: 8]
  -d, --dedup-batches
          Deduplicate k-mer batches to save some memory.
  -m, --mem-gb <MEM_GB>
          Memory available when building on temp disk space (in gigabytes). [default: 4]
      --temp-dir <TEMP_DIR>
          Build on temporary disk space at this path instead of in-memory.
```


## kbo-cli_kbo build

### Tool Description
Build a k-mer index

### Metadata
- **Docker Image**: quay.io/biocontainers/kbo-cli:0.2.1--h4349ce8_0
- **Homepage**: https://docs.rs/kbo
- **Package**: https://anaconda.org/channels/bioconda/packages/kbo-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: kbo build [OPTIONS] --input-list <INPUT_LIST> --output-prefix <OUTPUT_PREFIX> <SEQ_FILES>...

Arguments:
  <SEQ_FILES>...  Sequence data file(s).

Options:
  -t, --threads <NUM_THREADS>  [default: 1]
      --verbose                
  -h, --help                   Print help
  -V, --version                Print version

Input:
  -l, --input-list <INPUT_LIST>  File with paths or tab separated name and path on each line.

Output:
  -o, --output-prefix <OUTPUT_PREFIX>  Prefix for output files <prefix>.sbwt and <prefix>.lcs.

Build options:
  -k <KMER_SIZE>
          k-mer size, larger values are slower and use more space. [default: 31]
  -p, --prefix-precalc <PREFIX_PRECALC>
          Length of precalculated prefixes included in the index. [default: 8]
  -d, --dedup-batches
          Deduplicate k-mer batches to save some memory.
  -m, --mem-gb <MEM_GB>
          Memory available when building on temp disk space (in gigabytes). [default: 4]
      --temp-dir <TEMP_DIR>
          Build on temporary disk space at this path instead of in-memory.
```

