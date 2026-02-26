# merfishtools CWL Generation Report

## merfishtools_exp

### Tool Description
Estimate expressions for each feature (e.g. gene or transcript) in each cell.

### Metadata
- **Docker Image**: quay.io/biocontainers/merfishtools:1.5.0--py312h9d36253_3
- **Homepage**: https://merfishtools.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/merfishtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/merfishtools/overview
- **Total Downloads**: 49.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
merfishtools-exp 
Estimate expressions for each feature (e.g. gene or transcript) in each cell.

USAGE:
    merfishtools exp [OPTIONS] <CODEBOOK-TSV> <READOUTS> --seed <INT>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -e, --estimate <TSV-FILE>        Path to write expected value and standard deviation estimates of expression to.
                                     Output is formatted into columns: cell, feature, expected value, standard deviation
        --stats <TSV-FILE>           Path to write global statistics per cell to.
                                     Output is formatted into columns: cell, noise-rate
        --seed <INT>                 Seed for shuffling that occurs in EM algorithm.
        --p0 <FLOAT>...              Prior probability of 0->1 error [default: 0.04]
        --p1 <FLOAT>...              Prior probability of 1->0 error [default: 0.1]
        --cells <REGEX>              Regular expression to select cells from cell column (see above). [default: .*]
        --pmf-window-width <INT,>    Width of the window to calculate PMF for. [default: 100]
    -t, --threads <INT>              Number of threads to use. [default: 1]

ARGS:
    <CODEBOOK-TSV>    Path to codebook definition consisting of tab separated columns: feature, codeword.
                      Misidentification probes (see Chen et al. Science 2015) should not be contained in the
                      codebook.
    <READOUTS>        Raw readout data containing molecule assignments to positions.
                      If given as TSV file (ending on .tsv), the following columns are expected:
                      
                      cell
                      feature
                      hamming_dist
                      cell_position_x
                      cell_position_y
                      rna_position_x
                      rna_position_y
                      
                      Otherwise, the official MERFISH binary format is expected.

This command estimates expressions for each feature (e.g. gene or transcript) in each cell.
Results are provided as PMF (probability mass function) in columns:

cell
feature (e.g. gene, rna)
expression
posterior probability

Example usage:

merfishtools exp codebook.txt < data.txt > expression.txt
```


## merfishtools_diffexp

### Tool Description
Test for differential expression between two groups of cells.

### Metadata
- **Docker Image**: quay.io/biocontainers/merfishtools:1.5.0--py312h9d36253_3
- **Homepage**: https://merfishtools.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/merfishtools/overview
- **Validation**: PASS

### Original Help Text
```text
merfishtools-diffexp 
Test for differential expression between two groups of cells.

USAGE:
    merfishtools diffexp [OPTIONS] <group1> <group2>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --max-null-log2fc <FLOAT>    Maximum absolute log2 fold change considered as no differential expression [1.0].
        --pseudocounts <FLOAT>       Pseudocounts to add to means before fold change calculation [1.0].
        --cdf <FILE>                 Path to write CDFs of log2 fold changes to.
    -t, --threads <INT>              Number of threads to use.

ARGS:
    <group1>    Path to expression PMFs for group of cells.
    <group2>    Path to expression PMFs for group of cells.

This command calculates, for given expression PMFs (generated with merfishtools exp), differentially expressed features
(e.g. genes or transcripts) between groups of cells given as separate input data.
Results are provided as columns:

feature (e.g. gene, rna)
posterior error probability (PEP) for differential expression
expected FDR when selecting all features down to the current
bayes factor (BF) for differential expression
expected log2 fold change of first vs second group
standard deviation of log2 fold change
lower and upper bound of 95% credible interval of log2 fold change

Example usage:

merfishtools diffexp data1.txt data2.txt > diffexp.txt
```


## merfishtools_multidiffexp

### Tool Description
Test for differential expression between multiple groups of cells.

### Metadata
- **Docker Image**: quay.io/biocontainers/merfishtools:1.5.0--py312h9d36253_3
- **Homepage**: https://merfishtools.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/merfishtools/overview
- **Validation**: PASS

### Original Help Text
```text
merfishtools-multidiffexp 
Test for differential expression between multiple groups of cells.

USAGE:
    merfishtools multidiffexp [OPTIONS] <groups>...

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --max-null-cv <FLOAT>     Maximum coefficient of variation (CV) considered as no differential expression [0.5].
        --pseudocounts <FLOAT>    Pseudocounts to add to means before CV calculation [1.0].
        --cdf <FILE>              Path to write CDFs of CVs to.
    -t, --threads <INT>           Number of threads to use.

ARGS:
    <groups>...    Paths to expression PMFs for groups of cells.

This command calculates, for given expression PMFs (obtained with merfishtools exp), differentially expressed features
(e.g. genes or transcripts) between groups of cells given as separate input data.
Results are provided as columns:

feature (e.g. gene, rna)
posterior error probability (PEP) for differential expression
expected FDR when selecting all features down to the current
bayes factor (BF) for differential expression
expected coefficient of variation (CV)
standard deviation of CV
lower and upper bound of 95% credible interval of CV

Example usage:

merfishtools multidiffexp data1.txt data2.txt data3.txt > diffexp.txt
```


## merfishtools_gen-mhd4

### Tool Description
Generate MERFISH MHD4 codebook with given parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/merfishtools:1.5.0--py312h9d36253_3
- **Homepage**: https://merfishtools.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/merfishtools/overview
- **Validation**: PASS

### Original Help Text
```text
merfishtools-gen-mhd4 
Generate MERFISH MHD4 codebook with given parameters.

USAGE:
    merfishtools gen-mhd4 [OPTIONS] --onebits <INT>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -m, --onebits <INT>              Number of 1-bits.
        --not-expressed <PATTERN>    Regular expression pattern for features that should be marked
                                     as not expressed. This is useful to correctly model, e.g.,
                                     misidentification probes.

This command generates a codebook with the given parameters.
Currently, the number of bits (N) is fixed to 16.

Example usage:

merfishtools gen-mhd4 -m 8 < transcript-names.txt > codebook.tsv

The output file codebook.tsv will contain the columns

feature (e.g. gene or transcript)
codeword
```


## merfishtools_gen-mhd2

### Tool Description
Generate MERFISH MHD2 codebook with given parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/merfishtools:1.5.0--py312h9d36253_3
- **Homepage**: https://merfishtools.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/merfishtools/overview
- **Validation**: PASS

### Original Help Text
```text
merfishtools-gen-mhd2 
Generate MERFISH MHD2 codebook with given parameters.

USAGE:
    merfishtools gen-mhd2 [OPTIONS] --bits <INT> --onebits <INT>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -N, --bits <INT>                 Number of bits.
    -m, --onebits <INT>              Number of 1-bits.
        --not-expressed <PATTERN>    Regular expression pattern for features that should be marked
                                     as not expressed. This is useful to correctly model, e.g.,
                                     misidentification probes.

This command generates a codebook with the given parameters.

Example usage:

merfishtools gen-mhd2 -m 8 -N 16 < transcript-names.txt > codebook.tsv

The output file codebook.tsv will contain the columns

feature (e.g. gene or transcript)
codeword
```


## merfishtools_est-error-rates

### Tool Description
Estimate 0-1 and 1-0 error rates.

### Metadata
- **Docker Image**: quay.io/biocontainers/merfishtools:1.5.0--py312h9d36253_3
- **Homepage**: https://merfishtools.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/merfishtools/overview
- **Validation**: PASS

### Original Help Text
```text
merfishtools-est-error-rates 
Estimate 0-1 and 1-0 error rates.

USAGE:
    merfishtools est-error-rates <TSV-FILE> <RAW-DATA>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

ARGS:
    <TSV-FILE>    Path to codebook file.
    <RAW-DATA>    Raw data containing molecule assignments to positions.
                  If given as TSV file (ending on .tsv), the following columns are expected:
                  
                  cell
                  feature
                  readout
                  
                  Otherwise, the official MERFISH binary format is expected.

This command estimates 0-1 and 1-0 error rates from given MERFISH
readouts.

Example usage:

merfishtools est-error-rates readouts.tsv > error-rates.tsv

The produced output will have the three columns

pos
p0
p1

representing the position in the binary word, the 0-1 error rate and
the 1-0 error rate.
```

