# taxmapper CWL Generation Report

## taxmapper_search

### Tool Description
Search for taxonomic assignments using RAPSearch.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxmapper:1.0.2--py36_0
- **Homepage**: https://bitbucket.org/dbeisser/taxmapper
- **Package**: https://anaconda.org/channels/bioconda/packages/taxmapper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/taxmapper/overview
- **Total Downloads**: 19.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: taxmapper search [-h] -f FILE1 [-r FILE2] [--rapsearch RAPSEARCH] -d
                        DATABASE [-o OUTPUT] [-t THREADS]

optional arguments:
  -h, --help            show this help message and exit
  -f FILE1, --forward FILE1
                        Forward reads in fasta or fastq format
  -r FILE2, --reverse FILE2
                        Reads in fasta or fastq format [optional]
  --rapsearch RAPSEARCH
                        Rapsearch path, version >=2.24 [default: rapsearch set
                        in PATH variable]
  -d DATABASE, --database DATABASE
                        Path to RAPSearch database index
  -o OUTPUT, --out OUTPUT
                        Basename for output files [default: <input>_hits]
  -t THREADS, --threads THREADS
                        Number of threads [default: 4]
```


## taxmapper_map

### Tool Description
Map reads to taxa

### Metadata
- **Docker Image**: quay.io/biocontainers/taxmapper:1.0.2--py36_0
- **Homepage**: https://bitbucket.org/dbeisser/taxmapper
- **Package**: https://anaconda.org/channels/bioconda/packages/taxmapper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxmapper map [-h] -m LENGTH -f FILE1 [-r FILE2] [-o OUTPUT]
                     [-c COMBINE] [-t THREADS]

optional arguments:
  -h, --help            show this help message and exit
  -m LENGTH             Maximum read length
  -f FILE1, --forward FILE1
                        Forward read aln file
  -r FILE2, --reverse FILE2
                        Reverse read aln file [optional]
  -o OUTPUT, --out OUTPUT
                        Output file [default: taxa.tsv]
  -c COMBINE, --combine COMBINE
                        How to combine forward and reverse hits, for
                        "concordant" forward and reverse have to map to the
                        same taxon, for "best" the best hit from forward and
                        reverse is returned [default: best]
  -t THREADS, --threads THREADS
                        Number of threads, used to map forward and reverse
                        reads in parallel [default: 2]
```


## taxmapper_filter

### Tool Description
Filter taxonomy mapping file based on various thresholds.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxmapper:1.0.2--py36_0
- **Homepage**: https://bitbucket.org/dbeisser/taxmapper
- **Package**: https://anaconda.org/channels/bioconda/packages/taxmapper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxmapper filter [-h] -i TAXA [-o OUTPUT] [-a AUTOMATIC]
                        [--identity IDENTITY] [-r RATIO] [--evalue EVALUE]
                        [-d DIFF]

optional arguments:
  -h, --help            show this help message and exit
  -i TAXA, --tax TAXA   Taxonomy mapping file (taxa.tsv if not specified
                        otherwise).
  -o OUTPUT, --out OUTPUT
                        Output file [default: taxa_filtered.tsv]
  -a AUTOMATIC, --auto AUTOMATIC
                        Automatic filter with probability threshold, if
                        automatic filter is chosen all other thresholds will
                        be ignored [nan or 0 - 1, default: 0.4]
  --identity IDENTITY   Threshold for identity of best hit [default: nan]
  -r RATIO, --identity-ratio RATIO
                        Threshold for identity ratio [1 - 10, default: nan]
  --evalue EVALUE       Threshold for log e-values of best hit [default: nan]
  -d DIFF, --evalue-diff DIFF
                        Threshold for absolute difference in e-values [0 -
                        100, default: nan]
```


## taxmapper_count

### Tool Description
Count taxa based on a filtered taxonomy mapping file.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxmapper:1.0.2--py36_0
- **Homepage**: https://bitbucket.org/dbeisser/taxmapper
- **Package**: https://anaconda.org/channels/bioconda/packages/taxmapper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxmapper count [-h] -i TAXA [--out1 OUTPUT1] [--out2 OUTPUT2]

optional arguments:
  -h, --help           show this help message and exit
  -i TAXA, --tax TAXA  Filtered taxonomy mapping file.
  --out1 OUTPUT1       Output file 1, counted taxa for first taxonomic
                       hierarchy [default: taxa_counts_level1.tsv]
  --out2 OUTPUT2       Output file 2, counted taxa for second taxonomic
                       hierarchy [default: taxa_counts_level2.tsv]
```


## taxmapper_plot

### Tool Description
Plotting tool for taxonomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxmapper:1.0.2--py36_0
- **Homepage**: https://bitbucket.org/dbeisser/taxmapper
- **Package**: https://anaconda.org/channels/bioconda/packages/taxmapper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxmapper plot [-h] -t TAXA [TAXA ...] [-s SAMPLES [SAMPLES ...]]
                      [-f FREQ] [-c COUNTS] [-p PLOT]

optional arguments:
  -h, --help            show this help message and exit
  -t TAXA [TAXA ...], --taxa TAXA [TAXA ...]
                        Taxonomy file(s), counted taxa for a taxonomic
                        hierarchy
  -s SAMPLES [SAMPLES ...], --samples SAMPLES [SAMPLES ...]
                        Optional sample names, sample names have to be in the
                        same order as taxonomy input files. If no samplenames
                        are provided, the base names of the taxa file(s) will
                        be used.
  -f FREQ, --freq FREQ  Output file 1, taxon matrix with normalized
                        frequencies [default: taxa_freq_norm.tsv]
  -c COUNTS, --counts COUNTS
                        Output file 2, taxon matrix with counts [default:
                        taxa_counts.tsv]
  -p PLOT, --plot PLOT  Output file 3, stacked barplot of total count
                        normalized taxa [default: taxa_freq_norm.svg]
```


## taxmapper_run

### Tool Description
Run Taxmapper

### Metadata
- **Docker Image**: quay.io/biocontainers/taxmapper:1.0.2--py36_0
- **Homepage**: https://bitbucket.org/dbeisser/taxmapper
- **Package**: https://anaconda.org/channels/bioconda/packages/taxmapper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxmapper run [-h] -d DATABASE -f FOLDER [-r REVERSE] [-s SUFFIX] -m
                     LENGTH [-o OUTPUT] [-t THREADS]

optional arguments:
  -h, --help            show this help message and exit
  -d DATABASE, --database DATABASE
                        Database path for RAPseach database index
  -f FOLDER, --folder FOLDER
                        Folder with reads in fasta or fastq format
  -r REVERSE, --reverse REVERSE
                        Reads also contain reverse read, [default: True]
  -s SUFFIX, --suffix SUFFIX
                        Suffix of paired end reads, [default: "_R1,_R2"]
  -m LENGTH             Maximum read length
  -o OUTPUT, --out OUTPUT
                        Output folder, [default: "results"]
  -t THREADS, --threads THREADS
                        Number of threads, [default: 4]
```


## Metadata
- **Skill**: generated
