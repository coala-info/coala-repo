# tadrep CWL Generation Report

## tadrep_setup

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/oschwengers/tadrep
- **Package**: https://anaconda.org/channels/bioconda/packages/tadrep/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/tadrep/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/oschwengers/tadrep
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: TaDReP setup [-h]

options:
  -h, --help  show this help message and exit
```


## tadrep_database

### Tool Description
Import external databases for TaDReP.

### Metadata
- **Docker Image**: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/oschwengers/tadrep
- **Package**: https://anaconda.org/channels/bioconda/packages/tadrep/overview
- **Validation**: PASS

### Original Help Text
```text
usage: TaDReP database [-h] [--type {refseq,plsdb}] [--force]

options:
  -h, --help            show this help message and exit

Input / Output:
  --type {refseq,plsdb}
                        External DB to import (default = 'refseq')
  --force, -f           Force download and new setup of database
```


## tadrep_extract

### Tool Description
Extracts sequences from input files based on specified criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/oschwengers/tadrep
- **Package**: https://anaconda.org/channels/bioconda/packages/tadrep/overview
- **Validation**: PASS

### Original Help Text
```text
usage: TaDReP extract [-h] [--type {genome,plasmid,draft}] [--header HEADER]
                      [--files FILES [FILES ...]]
                      [--discard-longest DISCARD_LONGEST]
                      [--max-length MAX_LENGTH]

options:
  -h, --help            show this help message and exit

Input:
  --type {genome,plasmid,draft}, -t {genome,plasmid,draft}
                        Type of input files
  --header HEADER       Template for header description inside input files:
                        e.g.: header: ">pl1234" --> --header "pl"
  --files FILES [FILES ...], -f FILES [FILES ...]
                        File path
  --discard-longest DISCARD_LONGEST, -d DISCARD_LONGEST
                        Discard n longest sequences in output
  --max-length MAX_LENGTH, -m MAX_LENGTH
                        Max sequence length (default = 1000000 bp)
```


## tadrep_characterize

### Tool Description
Import json file from a given database path into working directory

### Metadata
- **Docker Image**: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/oschwengers/tadrep
- **Package**: https://anaconda.org/channels/bioconda/packages/tadrep/overview
- **Validation**: PASS

### Original Help Text
```text
usage: TaDReP characterize [-h] [--db DATABASE] [--inc-types INC_TYPES]

options:
  -h, --help            show this help message and exit

Input:
  --db DATABASE         Import json file from a given database path into
                        working directory
  --inc-types INC_TYPES
                        Import inc-types from given path into working
                        directory
```


## tadrep_cluster

### Tool Description
Cluster plasmids based on sequence identity and length difference.

### Metadata
- **Docker Image**: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/oschwengers/tadrep
- **Package**: https://anaconda.org/channels/bioconda/packages/tadrep/overview
- **Validation**: PASS

### Original Help Text
```text
usage: TaDReP cluster [-h] [--min-sequence-identity [1-100]]
                      [--max-sequence-length-difference [1-1000000]] [--skip]

options:
  -h, --help            show this help message and exit

Parameter:
  --min-sequence-identity [1-100]
                        Minimal plasmid sequence identity (default = 90%)
  --max-sequence-length-difference [1-1000000]
                        Maximal plasmid sequence length difference in
                        basepairs (default = 1000)
  --skip, -s            Skips clustering, one group for each plasmid
```


## tadrep_detect

### Tool Description
Detects plasmids in a draft genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/oschwengers/tadrep
- **Package**: https://anaconda.org/channels/bioconda/packages/tadrep/overview
- **Validation**: PASS

### Original Help Text
```text
usage: TaDReP detect [-h] [--genome GENOME [GENOME ...]]
                     [--min-contig-coverage [1-100]]
                     [--min-contig-identity [1-100]]
                     [--min-plasmid-coverage [1-100]]
                     [--min-plasmid-identity [1-100]]
                     [--gap-sequence-length GAP_SEQUENCE_LENGTH]

options:
  -h, --help            show this help message and exit

Input / Output:
  --genome GENOME [GENOME ...], -g GENOME [GENOME ...]
                        Draft genome path

Detection:
  --min-contig-coverage [1-100]
                        Minimal contig coverage (default = 90%)
  --min-contig-identity [1-100]
                        Maximal contig identity (default = 90%)
  --min-plasmid-coverage [1-100]
                        Minimal plasmid coverage (default = 80%)
  --min-plasmid-identity [1-100]
                        Minimal plasmid identity (default = 90%)
  --gap-sequence-length GAP_SEQUENCE_LENGTH
                        Gap sequence N length (default = 10)
```


## tadrep_visualize

### Tool Description
Visualize TaDReP results

### Metadata
- **Docker Image**: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
- **Homepage**: https://github.com/oschwengers/tadrep
- **Package**: https://anaconda.org/channels/bioconda/packages/tadrep/overview
- **Validation**: PASS

### Original Help Text
```text
usage: TaDReP visualize [-h]
                        [--plot-style {bigarrow,arrow,bigbox,box,bigrbox,rbox}]
                        [--label-color LABEL_COLOR] [--line-width LINE_WIDTH]
                        [--arrow-shaft-ratio ARROW_SHAFT_RATIO]
                        [--size-ratio SIZE_RATIO] [--label-size LABEL_SIZE]
                        [--label-rotation LABEL_ROTATION]
                        [--label-hpos {left,center,right}]
                        [--label-ha {left,center,right}]
                        [--interval-start [0-100]]
                        [--number-of-intervals [1-100]] [--omit-ratio [0-100]]

options:
  -h, --help            show this help message and exit

Style:
  --plot-style {bigarrow,arrow,bigbox,box,bigrbox,rbox}
                        Contig representation in plot (default = "box")
  --label-color LABEL_COLOR
                        Contig label color (default = "black")
  --line-width LINE_WIDTH
                        Contig edge linewidth (default = 0)
  --arrow-shaft-ratio ARROW_SHAFT_RATIO
                        Size ratio between arrow head and shaft (default =
                        0.5)
  --size-ratio SIZE_RATIO
                        Contig size ratio to track (default = 1.0)

Label:
  --label-size LABEL_SIZE
                        Contig label size (default = 15)
  --label-rotation LABEL_ROTATION
                        Contig label rotation (default = 45)
  --label-hpos {left,center,right}
                        Contig label horizontal position (default = "center")
  --label-ha {left,center,right}
                        Contig label horizontal alignment (default = "left")

Gradient:
  --interval-start [0-100]
                        Percentage where gradient should stop (default = 80%)
  --number-of-intervals [1-100]
                        Number of gradient intervals (default = 10)

Omit:
  --omit-ratio [0-100]  Omit contigs shorter than X percent of plasmid length
                        from plot (default = 1%)
```


## Metadata
- **Skill**: generated
