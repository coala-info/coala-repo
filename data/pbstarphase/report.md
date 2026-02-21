# pbstarphase CWL Generation Report

## pbstarphase_build

### Tool Description
Download and build the database for StarPhase

### Metadata
- **Docker Image**: quay.io/biocontainers/pbstarphase:2.0.1--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pb-StarPhase
- **Package**: https://anaconda.org/channels/bioconda/packages/pbstarphase/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pbstarphase/overview
- **Total Downloads**: 21.6K
- **Last updated**: 2025-12-09
- **GitHub**: https://github.com/PacificBiosciences/pb-StarPhase
- **Stars**: N/A
### Original Help Text
```text
Download and build the database for StarPhase

Usage: pbstarphase build [OPTIONS] --reference <FASTA> --output-db <JSON>

Options:
  -v, --verbose...  Enable verbose output
  -h, --help        Print help
  -V, --version     Print version

Input/Output:
  -r, --reference <FASTA>     Reference FASTA file
  -o, --output-db <JSON>      Output database location (JSON)
  -b, --build-options <JSON>  User-provided build options (JSON)

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## pbstarphase_db-stat

### Tool Description
Generate statistics about a database file

### Metadata
- **Docker Image**: quay.io/biocontainers/pbstarphase:2.0.1--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pb-StarPhase
- **Package**: https://anaconda.org/channels/bioconda/packages/pbstarphase/overview
- **Validation**: PASS

### Original Help Text
```text
Generate statistics about a database file

Usage: pbstarphase db-stat [OPTIONS] --database <JSON>

Options:
  -v, --verbose...  Enable verbose output
  -h, --help        Print help
  -V, --version     Print version

Input/Output:
  -d, --database <JSON>  Input database file (JSON)

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## pbstarphase_diplotype

### Tool Description
Run the diplotyper on a dataset

### Metadata
- **Docker Image**: quay.io/biocontainers/pbstarphase:2.0.1--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/pb-StarPhase
- **Package**: https://anaconda.org/channels/bioconda/packages/pbstarphase/overview
- **Validation**: PASS

### Original Help Text
```text
Run the diplotyper on a dataset

Usage: pbstarphase diplotype [OPTIONS] --database <JSON> --reference <FASTA> --output-calls <JSON>

Options:
  -v, --verbose...  Enable verbose output
  -h, --help        Print help
  -V, --version     Print version

Input/Output:
  -d, --database <JSON>       Input database file (JSON)
  -r, --reference <FASTA>     Reference FASTA file
  -c, --vcf <VCF>             Input variant file in VCF format
  -s, --sv-vcf <VCF>          Input structural variant file in VCF format
  -b, --bam <BAM>             Input alignment file in BAM format, can be specified multiple times; required for HLA diplotyping
  -o, --output-calls <JSON>   Output diplotype call file (JSON)
      --pharmcat-tsv <TSV>    Output file that can be provided to PharmCAT for further call interpretation
      --include-set <TXT>     Optional file indicating the list of genes to include in diplotyping, one per line
      --exclude-set <TXT>     Optional file indicating the list of genes to exclude from diplotyping, one per line
      --output-debug <DIR>    Optional output debug folder
      --sample-name <STRING>  Sample name from the input VCFs (default: first sample)

HLA calling:
      --hla-require-dna         Requires HLA alleles to have a DNA sequence definition
      --max-error-rate <FLOAT>  The maximum error rate for a read to the HLA reference allele [default: 0.07]
      --min-cdf-prob <FLOAT>    The minimum cumulative distribution function probability for a heterozygous call [default: 0.001]
      --expected-maf <FLOAT>    Expected minor allele frequency; reduce to account for skew from sequencing bias [default: 0.45]

Variant parameters:
      --max-sv-length <BASEPAIRS>  The maximum length of an SV to consider, anything longer is ignored [default: 1000000]

CYP2D6 calling:
      --infer-connections  Enables inferrence of connected alleles based on population observations
      --normalize-d6-only  Disables normalizing coverage with D7 and hybrid alleles

Consensus (HLA and CYP2D6):
      --min-consensus-fraction <FLOAT>  The minimum fraction of sequences required to split into multiple consensuses (e.g. MAF) [default: 0.10]
      --min-consensus-count <COUNT>     The minimum counts of sequences required to split into multiple consensuses [default: 3]
      --dual-max-ed-delta <COUNT>       The edit distance delta threshold to stop tracking divergent sequences (efficiency heuristic) [default: 100]

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## Metadata
- **Skill**: generated
