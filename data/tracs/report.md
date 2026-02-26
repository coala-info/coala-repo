# tracs CWL Generation Report

## tracs_align

### Tool Description
Uses sourmash to identify reference genomes within a read set and then aligns reads to each reference using minimap2

### Metadata
- **Docker Image**: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
- **Homepage**: https://github.com/gtonkinhill/tracs
- **Package**: https://anaconda.org/channels/bioconda/packages/tracs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tracs/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gtonkinhill/tracs
- **Stars**: N/A
### Original Help Text
```text
usage: tracs align [-h] -i INPUT_FILES [INPUT_FILES ...] [--database DATABASE]
                   [--refseqs REFSEQS] -o OUTPUT_DIR [-p PREFIX]
                   [--minimap_preset MINIMAP_PRESET] [-Q MIN_BASE_QUAL]
                   [-q MIN_MAP_QUAL] [-l MIN_QUERY_LEN] [-V MAX_DIV]
                   [--trim TRIM] [--consensus] [--min-cov MIN_COV]
                   [--keep-cov-outliers] [--error-perc ERROR_THRESHOLD]
                   [--either-strand] [--keep-all] [-t N_CPU]
                   [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Uses sourmash to identify reference genomes within a read set and then aligns
reads to each reference using minimap2

options:
  -h, --help            show this help message and exit
  -t N_CPU, --threads N_CPU
                        number of threads to use (default=1)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the logging threshold.

Input/output:
  -i INPUT_FILES [INPUT_FILES ...], --input INPUT_FILES [INPUT_FILES ...]
                        path to query signature
  --database DATABASE   path to database signatures
  --refseqs REFSEQS     path to reference fasta files
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        location of an output directory
  -p PREFIX, --prefix PREFIX
                        prefix to describe the input sample read files

Alignment options:
  --minimap_preset MINIMAP_PRESET
                        minimap preset to use - one of 'sr' (default), 'map-
                        ont' or 'map-pb'

Pileup options:
  -Q MIN_BASE_QUAL, --min_base_qual MIN_BASE_QUAL
                        minimum base quality (default=0)
  -q MIN_MAP_QUAL, --min_map_qual MIN_MAP_QUAL
                        minimum mapping quality (default=0)
  -l MIN_QUERY_LEN, --min_query_len MIN_QUERY_LEN
                        minimum query length (default=0)
  -V MAX_DIV, --max_div MAX_DIV
                        ignore queries with per-base divergence > max_div
                        (default=1)
  --trim TRIM           ignore bases within TRIM-bp from either end of a read
                        (default=0)

Posterior count estimates:
  --consensus           Turns on consensus mode. Only the most common allele
                        at each site will be reported and all other filters
                        will be ignored.
  --min-cov MIN_COV     Minimum read coverage (default=5).
  --keep-cov-outliers   Turns off filtering of genome regions with unusual
                        coverage. Useful if no gene gain/loss is expected.
  --error-perc ERROR_THRESHOLD
                        Threshold to exclude likely erroneous variants.
  --either-strand       turns off the requirement that a variant is supported
                        by both strands
  --keep-all            turns on filtering of variants with support below the
                        posterior frequency threshold
```


## tracs_combine

### Tool Description
Combine runs of TRACS'm align ready for distance estimation

### Metadata
- **Docker Image**: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
- **Homepage**: https://github.com/gtonkinhill/tracs
- **Package**: https://anaconda.org/channels/bioconda/packages/tracs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tracs combine [-h] -i DIRECTORIES [DIRECTORIES ...] -o OUTPUT_DIR
                     [-t N_CPU]
                     [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Combine runs of TRACS'm align ready for distance estimation

options:
  -h, --help            show this help message and exit
  -t N_CPU, --threads N_CPU
                        number of threads to use (default=1)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the logging threshold.

Input/output:
  -i DIRECTORIES [DIRECTORIES ...], --input DIRECTORIES [DIRECTORIES ...]
                        Paths to each directory containing the output of the
                        TRACS align function
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        name of the output driectory to store the combined
                        alignments.
```


## tracs_distance

### Tool Description
Estimates pairwise SNP and transmission distances between each pair of samples aligned to the same reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
- **Homepage**: https://github.com/gtonkinhill/tracs
- **Package**: https://anaconda.org/channels/bioconda/packages/tracs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tracs distance [-h] --msa MSA_FILES [MSA_FILES ...] [--msa-db MSA_DB]
                      [--meta METADATA] -o OUTPUT_FILE [-D SNP_THRESHOLD]
                      [--filter] [--clock_rate CLOCK_RATE]
                      [--trans_rate TRANS_RATE] [-K TRANS_THRESHOLD]
                      [--precision PRECISION] [-t N_CPU]
                      [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Estimates pairwise SNP and transmission distances between each pair of samples
aligned to the same reference genome.

options:
  -h, --help            show this help message and exit
  -t N_CPU, --threads N_CPU
                        number of threads to use (default=1)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the logging threshold.

Input/output:
  --msa MSA_FILES [MSA_FILES ...]
                        Input fasta files formatted by the align and merge
                        functions
  --msa-db MSA_DB       A database MSA used to compare each sequence to. By
                        default this is not uses and all pairwise comparisons
                        within each MSA are considered.
  --meta METADATA       Location of metadata in csv format. The first column
                        must include the sequence names and the second column
                        must include sampling dates.
  -o OUTPUT_FILE, --output OUTPUT_FILE
                        name of the output file to store the pairwise distance
                        estimates.

SNP distance options:
  -D SNP_THRESHOLD, --snp_threshold SNP_THRESHOLD
                        Only output those transmission pairs with a SNP
                        distance <= D
  --filter              Filter out regions with unusually high SNP distances
                        often caused by HGT

Transmission distance options:
  --clock_rate CLOCK_RATE
                        clock rate as defined in the transcluster paper
                        (SNPs/genome/year) default=1e-3 * 29903
  --trans_rate TRANS_RATE
                        transmission rate as defined in the transcluster paper
                        (transmissions/year) default=73
  -K TRANS_THRESHOLD, --trans_threshold TRANS_THRESHOLD
                        Only outputs those pairs where the most likely number
                        of intermediate hosts <= K
  --precision PRECISION
                        The precision used to calculate E(K) (default=0.01).
```


## tracs_threshold

### Tool Description
Estimates transmission thresholds.

### Metadata
- **Docker Image**: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
- **Homepage**: https://github.com/gtonkinhill/tracs
- **Package**: https://anaconda.org/channels/bioconda/packages/tracs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tracs threshold [-h] --close CLOSE_FILE --distant DISTANT_FILE -o
                       OUTPUT_FILE [--column COLUMN]

Estimates transmission thresholds.

options:
  -h, --help            show this help message and exit

Input/output:
  --close CLOSE_FILE    path to csv file with distances between isolates
                        mostly linked by recent transmission
  --distant DISTANT_FILE
                        path to csv file with distances between isolates not
                        related by recent transmission
  -o OUTPUT_FILE, --output OUTPUT_FILE
                        location of an output file
  --column COLUMN       index of column containing SNP distances (default=1)
```


## tracs_cluster

### Tool Description
Groups samples into putative transmission clusters using single linkage clustering

### Metadata
- **Docker Image**: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
- **Homepage**: https://github.com/gtonkinhill/tracs
- **Package**: https://anaconda.org/channels/bioconda/packages/tracs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tracs cluster [-h] -d DISTANCE_FILE -o OUTPUT_FILE -c THRESHOLD -D
                     {snp,filter,direct,expectedK}
                     [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Groups samples into putative transmission clusters using single linkage
clustering

options:
  -h, --help            show this help message and exit
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the logging threshold.

Input/output:
  -d DISTANCE_FILE, --distances DISTANCE_FILE
                        Pairwise distance estimates obtained from running the
                        'distance' function
  -o OUTPUT_FILE, --output OUTPUT_FILE
                        name of the output file to store the resulting cluster
                        assignments

Cluster options:
  -c THRESHOLD, --threshold THRESHOLD
                        Distance threshold. Samples will be grouped together
                        if the distance between them is below this threshold.
  -D {snp,filter,direct,expectedK}, --distance {snp,filter,direct,expectedK}
                        The type of transmission distance to use. Can be one
                        of 'snp', 'filter', 'direct', 'expectedK'
```


## tracs_build-db

### Tool Description
Builds a database for tracs

### Metadata
- **Docker Image**: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
- **Homepage**: https://github.com/gtonkinhill/tracs
- **Package**: https://anaconda.org/channels/bioconda/packages/tracs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tracs build-db [-h] -i INPUT_FILES [INPUT_FILES ...] -o DBNAME
                      [--ksize KSIZE] [--scale SCALE] [-t N_CPU]
                      [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Builds a database for tracs

options:
  -h, --help            show this help message and exit
  -i INPUT_FILES [INPUT_FILES ...], --input INPUT_FILES [INPUT_FILES ...]
                        path to genome fasta files (one per reference genome).
  -o DBNAME, --output DBNAME
                        name of the database file
  --ksize KSIZE         the kmer length used in sourmash (default=51)
  --scale SCALE         the scale used in sourmash (default=100)
  -t N_CPU, --threads N_CPU
                        number of threads to use (default=1)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the logging threshold.
```


## tracs_pipe

### Tool Description
A script to run the full TRACS pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
- **Homepage**: https://github.com/gtonkinhill/tracs
- **Package**: https://anaconda.org/channels/bioconda/packages/tracs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tracs pipe [-h] -i INPUT_FILE --database DATABASE [--refseqs REFSEQS]
                  -o OUTPUT_DIR [--meta METADATA]
                  [--minimap_preset MINIMAP_PRESET] [-Q MIN_BASE_QUAL]
                  [-q MIN_MAP_QUAL] [-l MIN_QUERY_LEN] [-V MAX_DIV]
                  [--trim TRIM] [--consensus] [--min-cov MIN_COV]
                  [--keep-cov-outliers] [--error-perc ERROR_THRESHOLD]
                  [--either-strand] [--keep-all] [-D SNP_THRESHOLD] [--filter]
                  [--clock_rate CLOCK_RATE] [--trans_rate TRANS_RATE]
                  [-K TRANS_THRESHOLD] [--precision PRECISION] [-c THRESHOLD]
                  [--cluster_distance {snp,filter,direct,expectedK}]
                  [-t N_CPU] [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

A script to run the full TRACS pipeline.

options:
  -h, --help            show this help message and exit
  -t N_CPU, --threads N_CPU
                        number of threads to use (default=1)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the logging threshold.

Input/output:
  -i INPUT_FILE, --input INPUT_FILE
                        path to text file containing input file paths
  --database DATABASE   path to database signatures
  --refseqs REFSEQS     path to reference fasta files
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        location of an output directory
  --meta METADATA       Location of metadata in csv format. The first column
                        must include the sequence names and the second column
                        must include sampling dates.

Alignment options:
  --minimap_preset MINIMAP_PRESET
                        minimap preset to use - one of 'sr' (default), 'map-
                        ont' or 'map-pb'

Pileup options:
  -Q MIN_BASE_QUAL, --min_base_qual MIN_BASE_QUAL
                        minimum base quality (default=0)
  -q MIN_MAP_QUAL, --min_map_qual MIN_MAP_QUAL
                        minimum mapping quality (default=0)
  -l MIN_QUERY_LEN, --min_query_len MIN_QUERY_LEN
                        minimum query length (default=0)
  -V MAX_DIV, --max_div MAX_DIV
                        ignore queries with per-base divergence > max_div
                        (default=1)
  --trim TRIM           ignore bases within TRIM-bp from either end of a read
                        (default=0)

Posterior count estimates:
  --consensus           Turns on consensus mode. Only the most common allele
                        at each site will be reported and all other filters
                        will be ignored.
  --min-cov MIN_COV     Minimum read coverage (default=5).
  --keep-cov-outliers   Turns off filtering of genome regions with unusual
                        coverage. Useful if no gene gain/loss is expected.
  --error-perc ERROR_THRESHOLD
                        Threshold to exclude likely erroneous variants prior
                        to fitting Dirichlet multinomial model
  --either-strand       turns off the requirement that a variant is supported
                        by both strands
  --keep-all            turns on filtering of variants with support below the
                        posterior frequency threshold

SNP distance options:
  -D SNP_THRESHOLD, --snp_threshold SNP_THRESHOLD
                        Only output those transmission pairs with a SNP
                        distance <= D
  --filter              Filter out regions with unusually high SNP distances
                        often caused by HGT

Transmission distance options:
  --clock_rate CLOCK_RATE
                        clock rate as defined in the transcluster paper
                        (SNPs/genome/year) default=1e-3 * 29903
  --trans_rate TRANS_RATE
                        transmission rate as defined in the transcluster paper
                        (transmissions/year) default=73
  -K TRANS_THRESHOLD, --trans_threshold TRANS_THRESHOLD
                        Only outputs those pairs where the most likely number
                        of intermediate hosts <= K
  --precision PRECISION
                        The precision used to calculate E(K) (default=0.01).

Cluster options:
  -c THRESHOLD, --cluster_threshold THRESHOLD
                        Distance threshold. Samples will be grouped together
                        if the distance between them is below this threshold.
                        (default=10)
  --cluster_distance {snp,filter,direct,expectedK}
                        The type of transmission distance to use. Can be one
                        of 'snp' (default), 'filter', 'direct', 'expectedK'
```


## tracs_plot

### Tool Description
Generates plots from a pileup file.

### Metadata
- **Docker Image**: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
- **Homepage**: https://github.com/gtonkinhill/tracs
- **Package**: https://anaconda.org/channels/bioconda/packages/tracs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tracs plot [-h] -i INPUT_FILES [INPUT_FILES ...] -p OUTPUT_FILE --type
                  {scatter,line,heatmap} [--min-freq MIN_FREQ]
                  [--either-strand] [--contigs CONTIGS [CONTIGS ...]]
                  [--column-name COLUMN_NAME] [--threshold THRESHOLD]
                  [--alpha ALPHA] [--height HEIGHT] [--width WIDTH]

Generates plots from a pileup file.

options:
  -h, --help            show this help message and exit

Input/output:
  -i INPUT_FILES [INPUT_FILES ...], --input INPUT_FILES [INPUT_FILES ...]
                        path to query signature
  -p OUTPUT_FILE, --prefix OUTPUT_FILE
                        prefix of output file
  --type {scatter,line,heatmap}
                        Type of plot (scatter, line, heatmap)

Pileup options:
  --min-freq MIN_FREQ   minimum frequency to include a variant (default=0.0)
  --either-strand       turns off the requirement that a variant is supported
                        by both strands
  --contigs CONTIGS [CONTIGS ...]
                        contigs for plotting (default=All)

Transmission distance options:
  --column-name COLUMN_NAME
                        Column name in distance matrix to use (default='SNP
                        distance')
  --threshold THRESHOLD
                        threshold to filter transmission distances
                        (default=None)

Plot options:
  --alpha ALPHA         alpha value for plotting (default=0.1)
  --height HEIGHT       height value for plotting (default=7)
  --width WIDTH         width value for plotting (default=10)
```

