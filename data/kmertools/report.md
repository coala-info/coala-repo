# kmertools CWL Generation Report

## kmertools_comp

### Tool Description
Generate sequence composition based features

### Metadata
- **Docker Image**: quay.io/biocontainers/kmertools:0.2.1--h5e00ca1_0
- **Homepage**: https://github.com/anuradhawick/kmertools
- **Package**: https://anaconda.org/channels/bioconda/packages/kmertools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kmertools/overview
- **Total Downloads**: 12.5K
- **Last updated**: 2025-09-24
- **GitHub**: https://github.com/anuradhawick/kmertools
- **Stars**: N/A
### Original Help Text
```text
Generate sequence composition based features

Usage: kmertools comp <COMMAND>

Commands:
  oligo  Generate oligonucleotide frequency vectors
  cgr    Generates Chaos Game Representations
  help   Print this message or the help of the given subcommand(s)

Options:
  -h, --help  Print help
```


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


## kmertools_Print

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmertools:0.2.1--h5e00ca1_0
- **Homepage**: https://github.com/anuradhawick/kmertools
- **Package**: https://anaconda.org/channels/bioconda/packages/kmertools/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
error: unrecognized subcommand 'Print'

Usage: kmertools <COMMAND>

For more information, try '--help'.
```


## Metadata
- **Skill**: generated
