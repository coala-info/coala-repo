# bxtools CWL Generation Report

## bxtools_split

### Tool Description
Split / count a BAM into multiple BAMs, one BAM per unique BX tag

### Metadata
- **Docker Image**: quay.io/biocontainers/bxtools:0.1.0--h13024bc_6
- **Homepage**: https://github.com/walaj/bxtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bxtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bxtools/overview
- **Total Downloads**: 12.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/walaj/bxtools
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage: bxtools split <BAM/SAM/CRAM> -a <id> > bxcounts.tsv
Description: Split / count a BAM into multiple BAMs, one BAM per unique BX tag

  General options
  -v, --verbose                        Select verbosity level (0-4). Default: 0 
  -h, --help                           Display this help and exit
  -a, --analysis-id                    ID to prefix output files with [foo]
  -x, --no-output                      Don't output BAMs (count only) [off]
  -m, --min-reads                      Minumum reads of given tag to see before writing [0]
  -t, --tag                            Split by a tag other than BX (e.g. MI)
```


## bxtools_stats

### Tool Description
Gather BX-level statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/bxtools:0.1.0--h13024bc_6
- **Homepage**: https://github.com/walaj/bxtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bxtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage: bxtools stat <BAM/SAM/CRAM> > stats.tsv
Description: Gather BX-level statistics

  General options
  -v, --verbose                        Set verbose output
  -t, --tag                            Collect stats by a tag other than BX (e.g. MI)
```


## bxtools_tile

### Tool Description
Gather BX counts on tiled ranges

### Metadata
- **Docker Image**: quay.io/biocontainers/bxtools:0.1.0--h13024bc_6
- **Homepage**: https://github.com/walaj/bxtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bxtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage: bxtools tile <BAM/SAM/CRAM> > tiles.bed
Description: Gather BX counts on tiled ranges

  General options
  -v, --verbose         Set verbose output
  -w, --width           Width of the tile [1000]
  -O, --overlap         Overlap of the tiles [0]
  -b, --bed             Rather than tile genome, input BED with regions
  -t, --tag             Tag other than BX to evaluate (e.g. MI)
```


## bxtools_group

### Tool Description
Tool functionality not yet implemented.

### Metadata
- **Docker Image**: quay.io/biocontainers/bxtools:0.1.0--h13024bc_6
- **Homepage**: https://github.com/walaj/bxtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bxtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
!! NOT YET IMPLEMENTED !!
```


## bxtools_relabel

### Tool Description
Move BX barcodes from BX tag to qname

### Metadata
- **Docker Image**: quay.io/biocontainers/bxtools:0.1.0--h13024bc_6
- **Homepage**: https://github.com/walaj/bxtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bxtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage: bxtools relabel input.bam > relabeled.bam 
Description: Move BX barcodes from BX tag to qname

  General options
  -v, --verbose                        Select verbosity level (0-4). Default: 0 
  -h, --help                           Display this help and exit
```


## bxtools_mol

### Tool Description
Return span of molecules from 10X data (using MI tag)

### Metadata
- **Docker Image**: quay.io/biocontainers/bxtools:0.1.0--h13024bc_6
- **Homepage**: https://github.com/walaj/bxtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bxtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage: bxtools mol <BAM/SAM/CRAM> > mol.bed
Description: Return span of molecules from 10X data (using MI tag)

  General options
  -v, --verbose         Set verbose output
```


## bxtools_convert

### Tool Description
Convert a BAM to a BX sorted BAM by switching BX and chromosome

### Metadata
- **Docker Image**: quay.io/biocontainers/bxtools:0.1.0--h13024bc_6
- **Homepage**: https://github.com/walaj/bxtools
- **Package**: https://anaconda.org/channels/bioconda/packages/bxtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

Usage: bxtools convert <BAM/SAM/CRAM> > converted.bam
Description: Convert a BAM to a BX sorted BAM by switching BX and chromosome

  General options
  -v, --verbose         Set verbose output
  -k, --keep-tags       Add chromosome tag (CR) and keep other tags. Default: delete all tags
  -t, --tag             Tag to flip for chromosome. Default: BX
```


## Metadata
- **Skill**: generated
