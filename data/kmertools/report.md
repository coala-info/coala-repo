# kmertools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| kmertools_comp_cgr | PASS |  |
| kmertools_comp_oligo | PASS |  |
| kmertools_cov | PASS |  |
| kmertools_ctr | PASS |  |
| kmertools_min | PASS |  |

## kmertools_cov

### Tool Description
Generates coverage histogram based on the reads

### Metadata
- **Docker Image**: quay.io/biocontainers/kmertools:0.2.1--h5e00ca1_0
- **Homepage**: https://github.com/anuradhawick/kmertools
- **Package**: https://anaconda.org/channels/bioconda/packages/kmertools/overview
- **Validation**: PASS

### Original Help Text
```text
Generates coverage histogram based on the reads

Usage: kmertools cov [OPTIONS] --input <INPUT> --output <OUTPUT>

Options:
  -i, --input <INPUT>
          Input file path

  -a, --alt-input <ALT_INPUT>
          Input file path, for k-mer counting

  -o, --output <OUTPUT>
          Output directory path

  -k, --k-size <K_SIZE>
          K size for the coverage histogram
          
          [default: 15]

  -p, --preset <PRESET>
          Output type to write

          Possible values:
          - csv: Comma separated format
          - tsv: Tab separated format
          - spc: Space separated format
          
          [default: spc]

  -s, --bin-size <BIN_SIZE>
          Bin size for the coverage histogram
          
          [default: 16]

  -c, --bin-count <BIN_COUNT>
          Number of bins for the coverage histogram
          
          [default: 16]

  -m, --memory <MEMORY>
          Max memory in GB
          
          [default: 6]

      --counts
          Disable normalisation and output raw counts

  -t, --threads <THREADS>
          Thread count for computations 0=auto
          
          [default: 0]

  -h, --help
          Print help (see a summary with '-h')
```

## kmertools_min

### Tool Description
Bin reads using minimisers

### Metadata
- **Docker Image**: quay.io/biocontainers/kmertools:0.2.1--h5e00ca1_0
- **Homepage**: https://github.com/anuradhawick/kmertools
- **Package**: https://anaconda.org/channels/bioconda/packages/kmertools/overview
- **Validation**: PASS

### Original Help Text
```text
Bin reads using minimisers

Usage: kmertools min [OPTIONS] --input <INPUT> --output <OUTPUT>

Options:
  -i, --input <INPUT>
          Input file path

  -o, --output <OUTPUT>
          Output vectors path

  -m, --m-size <M_SIZE>
          Minimiser size
          
          [default: 10]

  -w, --w-size <W_SIZE>
          Window size
          
          0 - emits one minimiser per sequence (useful for sequencing reads)
          w_size must be longer than m_size
          
          [default: 0]

  -p, --preset <PRESET>
          Output type to write

          Possible values:
          - s2m: Conver sequences into minimiser representation
          - m2s: Group sequences by minimiser
          
          [default: s2m]

  -t, --threads <THREADS>
          Thread count for computations 0=auto
          
          [default: 0]

  -h, --help
          Print help (see a summary with '-h')
```

## kmertools_ctr

### Tool Description
Count k-mers

### Metadata
- **Docker Image**: quay.io/biocontainers/kmertools:0.2.1--h5e00ca1_0
- **Homepage**: https://github.com/anuradhawick/kmertools
- **Package**: https://anaconda.org/channels/bioconda/packages/kmertools/overview
- **Validation**: PASS

### Original Help Text
```text
Count k-mers

Usage: kmertools ctr [OPTIONS] --input <INPUT> --output <OUTPUT> --k-size <K_SIZE>

Options:
  -i, --input <INPUT>
          Input file path

  -o, --output <OUTPUT>
          Output directory path

  -k, --k-size <K_SIZE>
          k size for counting

  -m, --memory <MEMORY>
          Max memory in GB
          
          [default: 6]

  -a, --acgt
          Output ACGT instead of numeric values
          
          This requires a larger space for the final result
          compared to the compact numeric representation

  -t, --threads <THREADS>
          Thread count for computations 0=auto
          
          [default: 0]

  -h, --help
          Print help (see a summary with '-h')
```

## kmertools_comp_oligo

### Tool Description
Generate oligonucleotide frequency vectors

### Metadata
- **Docker Image**: quay.io/biocontainers/kmertools:0.2.1--h5e00ca1_0
- **Homepage**: https://github.com/anuradhawick/kmertools
- **Package**: https://anaconda.org/channels/bioconda/packages/kmertools/overview
- **Validation**: PASS

### Original Help Text
```text
Generate oligonucleotide frequency vectors

Usage: kmertools comp oligo [OPTIONS] --input <INPUT> --output <OUTPUT>

Options:
  -i, --input <INPUT>      Input file path
  -o, --output <OUTPUT>    Output vectors path
  -c, --counts             Disable normalisation and output raw counts
  -k, --k-size <K_SIZE>    Set k-mer size [default: 3]
  -r, --raw-count          Raw counts
  -p, --preset <PRESET>    Output type to write [default: spc] [possible values: csv, tsv, spc]
  -H, --header             Include header (with k-mer in ACGT format)
  -t, --threads <THREADS>  Thread count for computations 0=auto [default: 0]
  -h, --help               Print help (see more with '--help')
```

## kmertools_comp_cgr

### Tool Description
Generates Chaos Game Representations

### Metadata
- **Docker Image**: quay.io/biocontainers/kmertools:0.2.1--h5e00ca1_0
- **Homepage**: https://github.com/anuradhawick/kmertools
- **Package**: https://anaconda.org/channels/bioconda/packages/kmertools/overview
- **Validation**: PASS

### Original Help Text
```text
Generates Chaos Game Representations

Usage: kmertools comp cgr [OPTIONS] --input <INPUT> --output <OUTPUT>

Options:
  -i, --input <INPUT>        Input file path
  -o, --output <OUTPUT>      Output vectors path
  -c, --counts               Disable normalisation and output raw counts (only with k-mer mode)
  -k, --k-size <K_SIZE>      Set k-mer size or default to full sequence CGR
  -v, --vec-size <VEC_SIZE>  Set vector size (output will be a square matrix with N=vecsize)
  -t, --threads <THREADS>    Thread count for computations 0=auto [default: 0]
  -h, --help                 Print help
```

## Metadata
- **Skill**: generated
