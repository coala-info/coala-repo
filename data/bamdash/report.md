# bamdash CWL Generation Report

## bamdash

### Tool Description
Generate a coverage plot from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamdash:0.4.5--pyhdfd78af_0
- **Homepage**: https://github.com/jonas-fuchs/BAMdash
- **Package**: https://anaconda.org/channels/bioconda/packages/bamdash/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamdash/overview
- **Total Downloads**: 8.7K
- **Last updated**: 2025-12-13
- **GitHub**: https://github.com/jonas-fuchs/BAMdash
- **Stars**: N/A
### Original Help Text
```text
usage: 	bamdash -b "bam file path" -r "reference_id" [additional arguments]

options:
  -h, --help            show this help message and exit
  -b, --bam             bam file location
  -r, --reference       seq reference id
  -q, --quality-threshold 15
                        qaulity threshold for reads
  -bs, --binsize        bins for the coverage plot
  -t, --tracks [track_1 ...]
                        file location of tracks
  -c, --coverage 5      minimum coverage
  --slider, --no-slider
                        show slider
  -e, --export_static None
                        export as png, jpg, pdf, svg
  -d, --dimensions px px
                        width and height of the static image in px
  --dump, --no-dump     dump annotated track data
  -v, --version         show program's version number and exit
```

