# minkemap CWL Generation Report

## minkemap

### Tool Description
MinkeMap: Circular Genome Visualization Tool

### Metadata
- **Docker Image**: quay.io/biocontainers/minkemap:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/erinyoung/MinkeMap
- **Package**: https://anaconda.org/channels/bioconda/packages/minkemap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/minkemap/overview
- **Total Downloads**: 39
- **Last updated**: 2025-12-14
- **GitHub**: https://github.com/erinyoung/MinkeMap
- **Stars**: N/A
### Original Help Text
```text
usage: minkemap [-h] [-v] -r REFERENCE [-i INPUT [INPUT ...]] [-f INPUT_FILE]
                [-o OUTPUT] [--outdir OUTDIR] [--track-width TRACK_WIDTH]
                [--track-gap TRACK_GAP] [--palette PALETTE] [--dpi DPI]
                [--title TITLE] [--no-legend] [--no-backbone]
                [--label-size LABEL_SIZE] [--annotations ANNOTATIONS]
                [--highlights HIGHLIGHTS] [--gc-skew] [--no-save-data]
                [--min-identity MIN_IDENTITY] [--min-coverage MIN_COVERAGE]
                [--exclude-genes EXCLUDE_GENES] [--verbose]

MinkeMap: Circular Genome Visualization Tool

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -r REFERENCE, --reference REFERENCE
                        Reference genome (FASTA or GenBank)
  -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                        Input sequencing files (FASTQ/FASTA)
  -f INPUT_FILE, --input-file INPUT_FILE
                        Manifest CSV file (cols: sample,read1,read2,type)
  -o OUTPUT, --output OUTPUT
                        Output filename
  --outdir OUTDIR       Directory to save all output files
  --track-width TRACK_WIDTH
                        Width of each track ring (default: 6)
  --track-gap TRACK_GAP
                        Gap between tracks (default: 4)
  --palette PALETTE     Color palette
  --dpi DPI             Image resolution
  --title TITLE         Plot title
  --no-legend           Hide the sample legend
  --no-backbone         Hide the black reference backbone
  --label-size LABEL_SIZE
                        Font size for gene/annotation labels
  --annotations ANNOTATIONS
                        CSV file for custom regions (cols:
                        reference,start,stop,label,color)
  --highlights HIGHLIGHTS
                        CSV file for background wedges (cols:
                        start,end,color,label)
  --gc-skew             Add a GC Skew track to the center
  --no-save-data        Do not generate BED/CSV data files
  --min-identity MIN_IDENTITY
                        Minimum identity % (0-100)
  --min-coverage MIN_COVERAGE
                        Minimum query coverage % (0-100)
  --exclude-genes EXCLUDE_GENES
                        Comma-separated list of terms to exclude from gene
                        track (e.g. 'hypothetical,putative')
  --verbose             Enable debug logging
```

