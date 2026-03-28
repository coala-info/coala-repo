# cami-amber CWL Generation Report

## cami-amber_amber.py

### Tool Description
AMBER: Assessment of Metagenome BinnERs

### Metadata
- **Docker Image**: quay.io/biocontainers/cami-amber:2.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/CAMI-challenge/AMBER
- **Package**: https://anaconda.org/channels/bioconda/packages/cami-amber/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cami-amber/overview
- **Total Downloads**: 13.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/CAMI-challenge/AMBER
- **Stars**: N/A
### Original Help Text
```text
usage: AMBER [-h] -g GOLD_STANDARD_FILE [-l LABELS] [-p FILTER]
             [-n MIN_LENGTH] -o OUTPUT_DIR [--stdout] [-d DESC]
             [--colors COLORS] [--silent] [--skip_gs] [-v]
             [-x MIN_COMPLETENESS] [-y MAX_CONTAMINATION] [-r REMOVE_GENOMES]
             [-k KEYWORD] [--genome_coverage GENOME_COVERAGE]
             [--ncbi_dir NCBI_DIR]
             bin_files [bin_files ...]

AMBER: Assessment of Metagenome BinnERs

positional arguments:
  bin_files             Binning files

options:
  -h, --help            show this help message and exit
  -g GOLD_STANDARD_FILE, --gold_standard_file GOLD_STANDARD_FILE
                        Gold standard - ground truth - file
  -l LABELS, --labels LABELS
                        Comma-separated binning names
  -p FILTER, --filter FILTER
                        Filter out [FILTER]% smallest genome bins (default: 0)
  -n MIN_LENGTH, --min_length MIN_LENGTH
                        Minimum length of sequences
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Directory to write the results to
  --stdout              Print summary to stdout
  -d DESC, --desc DESC  Description for HTML page
  --colors COLORS       Color indices
  --silent              Silent mode
  --skip_gs             Skip gold standard evaluation vs itself
  -v, --version         show program's version number and exit

genome binning-specific arguments:
  -x MIN_COMPLETENESS, --min_completeness MIN_COMPLETENESS
                        Comma-separated list of min. completeness thresholds
                        (default %: 50,70,90)
  -y MAX_CONTAMINATION, --max_contamination MAX_CONTAMINATION
                        Comma-separated list of max. contamination thresholds
                        (default %: 10,5)
  -r REMOVE_GENOMES, --remove_genomes REMOVE_GENOMES
                        File with list of genomes to be removed
  -k KEYWORD, --keyword KEYWORD
                        Keyword in the second column of file with list of
                        genomes to be removed (no keyword=remove all genomes
                        in list)
  --genome_coverage GENOME_COVERAGE
                        genome coverages

taxonomic binning-specific arguments:
  --ncbi_dir NCBI_DIR   Directory containing the NCBI taxonomy database dump
                        files nodes.dmp, merged.dmp, and names.dmp
```


## cami-amber_add_length_column.py

### Tool Description
Add length column _LENGTH to gold standard mapping and print mapping on the standard output

### Metadata
- **Docker Image**: quay.io/biocontainers/cami-amber:2.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/CAMI-challenge/AMBER
- **Package**: https://anaconda.org/channels/bioconda/packages/cami-amber/overview
- **Validation**: PASS

### Original Help Text
```text
usage: add_length_column.py [-h] -g GOLD_STANDARD_FILE -f FASTA_FILE

Add length column _LENGTH to gold standard mapping and print mapping on the
standard output

options:
  -h, --help            show this help message and exit
  -g GOLD_STANDARD_FILE, --gold_standard_file GOLD_STANDARD_FILE
                        Gold standard - ground truth - file
  -f FASTA_FILE, --fasta_file FASTA_FILE
                        FASTA or FASTQ file with sequences of gold standard
```


## cami-amber_convert_fasta_bins_to_biobox_format.py

### Tool Description
Convert bins in FASTA files to CAMI tsv format

### Metadata
- **Docker Image**: quay.io/biocontainers/cami-amber:2.0.7--pyhdfd78af_0
- **Homepage**: https://github.com/CAMI-challenge/AMBER
- **Package**: https://anaconda.org/channels/bioconda/packages/cami-amber/overview
- **Validation**: PASS

### Original Help Text
```text
usage: convert_fasta_bins_to_biobox_format.py [-h] [-o OUTPUT_FILE]
                                              paths [paths ...]

Convert bins in FASTA files to CAMI tsv format

positional arguments:
  paths                 FASTA files including full paths

options:
  -h, --help            show this help message and exit
  -o OUTPUT_FILE, --output_file OUTPUT_FILE
                        Output file
```


## Metadata
- **Skill**: generated
