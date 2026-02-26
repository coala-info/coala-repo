# methylmap CWL Generation Report

## methylmap

### Tool Description
Plotting tool for population scale nucleotide modifications.

### Metadata
- **Docker Image**: quay.io/biocontainers/methylmap:0.5.11--pyhdfd78af_0
- **Homepage**: https://github.com/EliseCoopman/methylmap
- **Package**: https://anaconda.org/channels/bioconda/packages/methylmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/methylmap/overview
- **Total Downloads**: 12.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/EliseCoopman/methylmap
- **Stars**: N/A
### Original Help Text
```text
usage: methylmap [-h] [-f FILES [FILES ...] | -t TABLE | -tsv TSV] [-w WINDOW]
                 [-n [NAMES ...]] --gff GFF [--output OUTPUT]
                 [--groups [GROUPS ...]] [-s] [--fasta FASTA] [--mod {m,h}]
                 [--hapl] [--dendro] [--threads THREADS] [--quiet] [--debug]
                 [--host HOST] [--port PORT] [-v]

Plotting tool for population scale nucleotide modifications.

options:
  -h, --help            show this help message and exit
  -f FILES [FILES ...], --files FILES [FILES ...]
                        list with BAM/CRAM files or nanopolish (processed with
                        calculate_methylation_frequency.py) files
  -t TABLE, --table TABLE
                        methfreqtable input
  -tsv TSV, --tsv TSV   overviewtable input
  -w WINDOW, --window WINDOW
                        region to visualise, format: chr:start-end (example:
                        chr20:58839718-58911192)
  -n [NAMES ...], --names [NAMES ...]
                        list with sample names
  --gff GFF             add annotation track based on GFF3 file
  --output OUTPUT       TSV file to write the frequencies to.
  --groups [GROUPS ...]
                        list of experimental group for each sample
  -s, --simplify        simplify annotation track to show genes rather than
                        transcripts
  --fasta FASTA         fasta reference file, required when input is BAM/CRAM
                        files or overviewtable with BAM/CRAM files
  --mod {m,h}           modified base of interest when BAM/CRAM files as
                        input. Options are: m, h, default = m
  --hapl                display modification frequencies in input BAM/CRAM
                        file for each haplotype (alternating haplotypes in
                        methylmap)
  --dendro              perform hierarchical clustering on the
                        samples/haplotypes and visualize with dendrogram on
                        sorted heatmap as output
  --threads THREADS     number of threads to use when processing BAM/CRAM
                        files
  --quiet               suppress modkit output
  --debug               Run the app in debug mode
  --host HOST           Host IP used to serve the application
  --port PORT           Port used to serve the application
  -v, --version         print version and exit
```

