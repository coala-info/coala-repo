# pastrami CWL Generation Report

## pastrami_all

### Tool Description
PASTRAMI tool for haplotype-based population structure analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
- **Homepage**: https://github.com/healthdisparities/pastrami
- **Package**: https://anaconda.org/channels/bioconda/packages/pastrami/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pastrami/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-11-05
- **GitHub**: https://github.com/healthdisparities/pastrami
- **Stars**: N/A
### Original Help Text
```text
[95m
usage: pastrami.py all [-h] [--reference-prefix <PREFIX>] [--query-prefix <TPED/TFAM>] [--haplotypes <TPED/TFAM>]
                       [--pop-group pop2group.txt] [--debug_mode] [--out-prefix out-prefix] [--map-dir maps/]
                       [--min-snps MinSNPs] [--max-snps MaxSNPs] [--max-rate MaxRate] [--per-individual]
                       [--log-file run.log] [--threads N] [--verbose]

options:
  -h, --help                   show this help message and exit

Required Input options:
  --reference-prefix <PREFIX>  Prefix for the reference TPED/TFAM input files
  --query-prefix <TPED/TFAM>   Prefix for the query TPED/TFAM input files
  --haplotypes <TPED/TFAM>     File of haplotype positions
  --pop-group pop2group.txt    File containing population to group (e.g., tribes to region) mapping
  --debug_mode                 Should all debugging file be produced in the output

Output options:
  --out-prefix out-prefix      Output prefix (default: pastrami) for creating following sets of files. <prefix>.pickle,
                               <prefix>_query.tsv, <prefix>.tsv, <prefix>.fam, <prefix>_fractions.Q,
                               <prefix>_paintings.Q, <prefix>_estimates.Q, <prefix>_fine_grain_estimates.Q

Optional arguments for hapmake stage:
  --map-dir maps/              Directory containing genetic maps: chr1.map, chr2.map, etc
  --min-snps MinSNPs           Minimum number of SNPs in a haplotype block (default: 7)
  --max-snps MaxSNPs           Maximum number of SNPs in a haplotype block (default: 20)
  --max-rate MaxRate           Maximum recombination rate (default: 0.3)

Runtime options:
  --per-individual             Generate per-individual copying rather than per-population copying
  --log-file, -l, --l run.log  File containing log information (default: run.log)
  --threads, -t N              Number of concurrent threads (default: 4)
  --verbose, -v                Print program progress information on screen
[0m
[91m

Errors:
all requires --reference-prefix
all requires --query-prefix
all requires --haplotypes or --map-dir
[0m
```


## pastrami_hapmake

### Tool Description
Generate haplotype blocks based on genetic maps and SNP constraints

### Metadata
- **Docker Image**: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
- **Homepage**: https://github.com/healthdisparities/pastrami
- **Package**: https://anaconda.org/channels/bioconda/packages/pastrami/overview
- **Validation**: PASS

### Original Help Text
```text
[95m
usage: pastrami.py hapmake [-h] [--map-dir maps/] [--min-snps MinSNPs] [--max-snps MaxSNPs] [--max-rate MaxRate]
                           [--haplotypes out.haplotypes] [--log-file run.log] [--threads N] [--verbose]

options:
  -h, --help                   show this help message and exit

Input options:
  --map-dir maps/              Directory containing genetic maps: chr1.map, chr2.map, etc
  --min-snps MinSNPs           Minimum number of SNPs in a haplotype block (default: 7)
  --max-snps MaxSNPs           Maximum number of SNPs in a haplotype block (default: 20)
  --max-rate MaxRate           Maximum recombination rate (default: 0.3)

Output options:
  --haplotypes out.haplotypes  Output file containing haplotypes (default: out.haplotypes)

Runtime options:
  --log-file, -l, --l run.log  File containing log information (default: run.log)
  --threads, -t N              Number of concurrent threads (default: 4)
  --verbose, -v                Print program progress information on screen
[0m
[91m

Errors:
hapmake requires --map-dir
[0m
```


## pastrami_build

### Tool Description
Build reference copying matrices and pickle files for PASTRAMI

### Metadata
- **Docker Image**: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
- **Homepage**: https://github.com/healthdisparities/pastrami
- **Package**: https://anaconda.org/channels/bioconda/packages/pastrami/overview
- **Validation**: PASS

### Original Help Text
```text
[95m
usage: pastrami.py build [-h] [--haplotypes <TSV>] [--reference-prefix <PREFIX>] [--reference-pickle-out <OUTPUT>]
                         [--reference-out <OUTPUT>] [--per-individual] [--log-file run.log] [--threads N] [--verbose]

options:
  -h, --help                       show this help message and exit

Input options:
  --haplotypes <TSV>               File of haplotype positions
  --reference-prefix <PREFIX>      Prefix for the reference TPED/TFAM input files

Output options:
  --reference-pickle-out <OUTPUT>  The reference pickle file output
  --reference-out <OUTPUT>         The reference copying matrix output

Runtime options:
  --per-individual                 Generate per-individual copying rather than per-population copying
  --log-file, -l, --l run.log      File containing log information (default: run.log)
  --threads, -t N                  Number of concurrent threads (default: 4)
  --verbose, -v                    Print program progress information on screen
[0m
[91m

Errors:
build requires --reference-prefix
build requires --haplotypes
[0m
```


## pastrami_query

### Tool Description
Query a reference pickle with TPED/TFAM input files to generate copying matrices.

### Metadata
- **Docker Image**: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
- **Homepage**: https://github.com/healthdisparities/pastrami
- **Package**: https://anaconda.org/channels/bioconda/packages/pastrami/overview
- **Validation**: PASS

### Original Help Text
```text
[95m
usage: pastrami.py query [-h] [--reference-pickle <PICKLE>] [--query-prefix <PREFIX>] [--query-out <OUTPUT>]
                         [--combined-out <OUTPUT>] [--log-file run.log] [--threads N] [--verbose]

options:
  -h, --help                   show this help message and exit

Input options:
  --reference-pickle <PICKLE>  A pre-made reference pickle
  --query-prefix <PREFIX>      Prefix for the query TPED/TFAM input files

Output options:
  --query-out <OUTPUT>         The query copying matrix output
  --combined-out <OUTPUT>      The combined reference/query copying matrix output

Runtime options:
  --log-file, -l, --l run.log  File containing log information (default: run.log)
  --threads, -t N              Number of concurrent threads (default: 4)
  --verbose, -v                Print program progress information on screen
[0m
[91m

Errors:
query requires --query-prefix
query requires --query-prefix
[0m
```


## pastrami_coanc

### Tool Description
Calculate copying matrices for reference and query haplotypes

### Metadata
- **Docker Image**: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
- **Homepage**: https://github.com/healthdisparities/pastrami
- **Package**: https://anaconda.org/channels/bioconda/packages/pastrami/overview
- **Validation**: PASS

### Original Help Text
```text
[95m
usage: pastrami.py coanc [-h] [--haplotypes <TSV>] [--reference-prefix <PICKLE>] [--query-prefix <PREFIX>]
                         [--reference-out <OUTPUT>] [--query-out <OUTPUT>] [--combined-out <OUTPUT>]
                         [--log-file run.log] [--threads N] [--verbose]

options:
  -h, --help                   show this help message and exit

Input options:
  --haplotypes <TSV>           File of haplotype positions
  --reference-prefix <PICKLE>  Prefix for the reference TPED/TFAM input files
  --query-prefix <PREFIX>      Prefix for the query TPED/TFAM input files

Output options:
  --reference-out <OUTPUT>     The reference v. reference copying matrix output
  --query-out <OUTPUT>         The query v. reference copying matrix output
  --combined-out <OUTPUT>      The all v. reference copying matrix output

Runtime options:
  --log-file, -l, --l run.log  File containing log information (default: run.log)
  --threads, -t N              Number of concurrent threads (default: 4)
  --verbose, -v                Print program progress information on screen
[0m
[91m

Errors:
coanc requires --reference-prefix
coanc requires --haplotypes
[0m
```


## pastrami_aggregate

### Tool Description
Aggregate Pastrami ancestry estimates based on population groupings

### Metadata
- **Docker Image**: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
- **Homepage**: https://github.com/healthdisparities/pastrami
- **Package**: https://anaconda.org/channels/bioconda/packages/pastrami/overview
- **Validation**: PASS

### Original Help Text
```text
[95m
usage: pastrami.py aggregate [-h] [--pastrami-output ancestry.tsv] [--pop-group pop2group.txt]
                             [--pastrami-fam african.fam] [--out-prefix out-prefix] [--log-file run.log] [--threads N]
                             [--verbose]

options:
  -h, --help                      show this help message and exit

Input options:
  --pastrami-output ancestry.tsv  Output file generated from Pastrami's query subcommand
  --pop-group pop2group.txt       File containing population to group (e.g., tribes to region) mapping
  --pastrami-fam african.fam      File containing individual and population mapping in FAM format

Output options:
  --out-prefix out-prefix         Output prefix for ancestry estimates files (default: pastrami). Four files are
                                  created: <prefix>_fractions.Q, <prefix>_paintings.Q, <prefix>_estimates.Q,
                                  <prefix>_fine_grain_estimates.Q

Runtime options:
  --log-file, -l, --l run.log     File containing log information (default: run.log)
  --threads, -t N                 Number of concurrent threads (default: 4)
  --verbose, -v                   Print program progress information on screen
[0m
[91m

Errors:
aggregate requires --pastrami-output
aggregate requires --pop-group
aggregate requires --pastrami-fam
[0m
```


## Metadata
- **Skill**: generated
