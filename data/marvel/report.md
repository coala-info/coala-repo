# marvel CWL Generation Report

## marvel

### Tool Description
Predict phage draft genomes in metagenomic bins.

### Metadata
- **Docker Image**: quay.io/biocontainers/marvel:0.2--py39hdfd78af_4
- **Homepage**: http://github.com/quadram-institute-bioscience/marvel/
- **Package**: https://anaconda.org/channels/bioconda/packages/marvel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/marvel/overview
- **Total Downloads**: 4.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/quadram-institute-bioscience/marvel
- **Stars**: N/A
### Original Help Text
```text
usage: marvel [-h] [-i INPUT_FOLDER] [-t THREADS] [-o OUTDIR] [-m CTGMINLEN]
              [-c CONFIDENCE] [-d DATABASEDIR] [-f] [-v] [--debug] [--keep]
              [--cite]

Predic phage draft genomes in metagenomic bins.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_FOLDER, --input-dir INPUT_FOLDER
                        Path to a folder containing metagenomic bins in .fa or
                        .fasta format
  -t THREADS, --threads THREADS
                        Number of CPU threads to be used by Prokka and hmmscan
                        (default=1)
  -o OUTDIR, --output-dir OUTDIR
                        Output directory
  -m CTGMINLEN, --min-len CTGMINLEN
                        Bin minimum size
  -c CONFIDENCE, --confidence CONFIDENCE
                        Confidence threshold
  -d DATABASEDIR, --db DATABASEDIR
                        Database directory
  -f, --force           Force overwrite
  -v, --verbose         Print verbose output
  --debug               Enable debug mode
  --keep                Keep all intermediate files
  --cite                Show citations
```

