# tecount CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tecount_TEcount | PASS | real repo test mouse chr19 BAM and RepeatMasker bed; class, family and subfamily counts plausible (SINE, LINE, LTR); added .bai secondaryFiles |

## tecount_TEcount

### Tool Description
Count reads mapping on Transposable Elements subfamilies, families and classes.

### Metadata
- **Docker Image**: quay.io/biocontainers/tecount:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/bodegalab/tecount
- **Package**: https://anaconda.org/channels/bioconda/packages/tecount/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tecount/overview
- **Total Downloads**: 7.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bodegalab/tecount
- **Stars**: N/A
### Original Help Text
```text
usage: TEcount -b <file.bam> -r <rmsk.bed.gz> [OPTIONS]

Count reads mapping on Transposable Elements subfamilies, families and
classes.

options:
  -h, --help            show this help message and exit
  -b BAM, --bam BAM     scRNA-seq reads aligned to a reference genome
  -r RMSK, --rmsk RMSK  Genomic TE coordinates in bed format, with subfamily,
                        family and class on columns 7, 8 and 9. Plain text or
                        gzip-compressed.
  -o OVERLAP, --overlap OVERLAP
                        Minimum bp overlap between read and feature (default:
                        1).
  -s STRANDNESS, --strandness STRANDNESS
                        Strandness of the library. One of: "unstranded"
                        (default), "forward", "reverse".
  --prefix PREFIX       Prefix for output file names (default: no prefix).
  --outdir OUTDIR       Output directory (default: current directory).
  --tmpdir TMPDIR       Temporary files directory (default: ./tmp).
  --keeptmp             Keep temporary files (default: False).
  -p THREADS, --threads THREADS
                        Number of cpus to use (default: 1)
  -V, --version         Print software version and quit.

Documentation and issue tracker: https://github.com/bodegalab/tecount
```

## Metadata
- **Skill**: generated
