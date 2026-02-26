# mercat2 CWL Generation Report

## mercat2_mercat2.py

### Tool Description
mercat2.py is a tool for kmer analysis of metagenomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/mercat2:1.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/raw-lab/mercat2
- **Package**: https://anaconda.org/channels/bioconda/packages/mercat2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mercat2/overview
- **Total Downloads**: 10.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/raw-lab/mercat2
- **Stars**: N/A
### Original Help Text
```text
usage: mercat2.py [-h] [-i I [I ...]] [-f F] -k K [-n N] [-c C] [-prod] [-fgs]
                  [-s S] [-o O] [-replace] [-lowmem LOWMEM] [-skipclean]
                  [-toupper] [-pca] [--version]

options:
  -h, --help      show this help message and exit
  -i I [I ...]    path to input file
  -f F            path to folder containing input files
  -k K            kmer length
  -n N            no of cores [auto detect]
  -c C            minimum kmer count [10]
  -prod           run Prodigal on fasta files
  -fgs            run FragGeneScanRS on fasta files
  -s S            Split into x MB files. [100]
  -o O            Output folder, default = 'mercat_results' in current
                  directory
  -replace        Replace existing output directory [False]
  -lowmem LOWMEM  Flag to use incremental PCA when low memory is available.
                  [auto]
  -skipclean      skip trimming of fastq files
  -toupper        convert all input sequences to uppercase
  -pca            create interactive PCA plot of the samples (minimum of 4
                  fasta files required)
  --version, -v   show the version number and exit
```

