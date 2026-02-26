# smncopynumbercaller CWL Generation Report

## smncopynumbercaller_smn_caller.py

### Tool Description
Call Copy number of full-length SMN1, full-length SMN2 and SMN* (Exon7-8 deletion) from a WGS bam file.

### Metadata
- **Docker Image**: quay.io/biocontainers/smncopynumbercaller:1.1.2--py312h7e72e81_1
- **Homepage**: https://github.com/Illumina/SMNCopyNumberCaller
- **Package**: https://anaconda.org/channels/bioconda/packages/smncopynumbercaller/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/smncopynumbercaller/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Illumina/SMNCopyNumberCaller
- **Stars**: N/A
### Original Help Text
```text
usage: smn_caller.py [-h] --manifest MANIFEST --genome GENOME --outDir OUTDIR
                     --prefix PREFIX [--threads THREADS]
                     [--reference REFERENCE] [--countFilePath COUNTFILEPATH]

Call Copy number of full-length SMN1, full-length SMN2 and SMN* (Exon7-8
deletion) from a WGS bam file.

options:
  -h, --help            show this help message and exit
  --manifest MANIFEST   Manifest listing absolute paths to input BAM/CRAM
                        files
  --genome GENOME       Reference genome, select from 19, 37, or 38
  --outDir OUTDIR       Output directory
  --prefix PREFIX       Prefix to output file
  --threads THREADS     Number of threads to use. Default is 1
  --reference REFERENCE
                        Optional path to reference fasta file for CRAM
  --countFilePath COUNTFILEPATH
                        Optional path to count files
```

