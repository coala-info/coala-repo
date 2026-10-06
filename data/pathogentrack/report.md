# pathogentrack CWL Generation Report

## Metadata
- **Skill**: generated

## pathogentrack_PathogenTrack

### Tool Description
A tool for counting microbes at single-cell levels, including trimming, extraction, filtering, alignment, classification, and quantification.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
- **Homepage**: https://github.com/ncrna/PathogenTrack
- **Package**: https://anaconda.org/channels/bioconda/packages/pathogentrack/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
[91m
error: argument -h/--help: ignored explicit argument 'elp'
[0m
usage: PathogenTrack [-h] [-v]
                     {count,trim,extract,filter,align,classify,quant} ...

positional arguments:
  {count,trim,extract,filter,align,classify,quant}
    count               one command to count microbes at single-cell levels
    trim                trim -1 at the end of barcode
    extract             extract and append barcode and UMI to the read2 name
    filter              filter out low quality / complexity reads
    align               align clean reads to the reference genome
    classify            classify unmapped reads to taxons
    quant               deduplication and quantification of microbes at
                        single-cell levels

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
```

