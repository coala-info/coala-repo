# svtopovz CWL Generation Report

## svtopovz

### Tool Description
Visualize structural variant calls from svtopo

### Metadata
- **Docker Image**: quay.io/biocontainers/svtopovz:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/PacificBiosciences/HiFi-SVTopo
- **Package**: https://anaconda.org/channels/bioconda/packages/svtopovz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svtopovz/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-07-22
- **GitHub**: https://github.com/PacificBiosciences/HiFi-SVTopo
- **Stars**: N/A
### Original Help Text
```text
usage: svtopovz [-h] [-v] --svtopo-dir SVTOPO_DIR
                [--annotation-bed [ANNOTATION_BED ...]] [--genes GENES]
                [--image-type {png,jpg,jpeg,svg,pdf}]
                [--max-gap-size-mb MAX_GAP_SIZE_MB] [--verbose]
                [--include-simple-breakpoints]

options:
  -h, --help            show this help message and exit
  -v, --version         Installed version (0.3.0)
  --svtopo-dir SVTOPO_DIR
                        path to directory containing one or more svtopo output
                        file pairs (in json and bed format). GZIP allowed.
                        (default: None)
  --annotation-bed [ANNOTATION_BED ...]
                        space delimited list of one or more paths to genome
                        annotations in BED file format - optionally allows
                        annotation title in column 4 and strand (+/-) in
                        column 5 (default: None)
  --genes GENES         single path to gene annotations in GFF3 or GTF format
                        (based on GENCODE v45 annotations) (default: None)
  --image-type {png,jpg,jpeg,svg,pdf}
                        type of image to generate (default: png)
  --max-gap-size-mb MAX_GAP_SIZE_MB
                        maximum gap size to show in one panel, in megabases.
                        Default is 0.5mB (default: 0.5)
  --verbose             print verbose output for debugging purposes (default:
                        False)
  --include-simple-breakpoints
                        does not skip simple single-breakpoint events, such as
                        deletions, duplications, and nonreciprocal
                        translocations (default: False)
```


## Metadata
- **Skill**: generated
