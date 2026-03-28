# trycycler CWL Generation Report

## trycycler_subsample

### Tool Description
subsample a long-read set

### Metadata
- **Docker Image**: quay.io/biocontainers/trycycler:0.5.6--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Trycycler
- **Package**: https://anaconda.org/channels/bioconda/packages/trycycler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/trycycler/overview
- **Total Downloads**: 26.1K
- **Last updated**: 2025-09-30
- **GitHub**: https://github.com/rrwick/Trycycler
- **Stars**: N/A
### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: trycycler subsample -r READS -o OUT_DIR [--count COUNT]
                           [--genome_size GENOME_SIZE]
                           [--min_read_depth MIN_READ_DEPTH] [-t THREADS] [-h]
                           [--version]

subsample a long-read set

Required arguments:
  -r READS, --reads READS
                          Input long reads (FASTQ format)
  -o OUT_DIR, --out_dir OUT_DIR
                          Output directory

Settings:
  --count COUNT           Number of subsampled read sets to output (default:
                          12)
  --genome_size GENOME_SIZE
                          Approximate genome size (default: auto)
  --min_read_depth MIN_READ_DEPTH
                          Minimum allowed read depth (default: 25.0)
  -t THREADS, --threads THREADS
                          Number of threads to use for alignment (default: 16)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## trycycler_cluster

### Tool Description
cluster contigs by similarity

### Metadata
- **Docker Image**: quay.io/biocontainers/trycycler:0.5.6--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Trycycler
- **Package**: https://anaconda.org/channels/bioconda/packages/trycycler/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: trycycler cluster -a ASSEMBLIES [ASSEMBLIES ...] -r READS -o OUT_DIR
                         [--min_contig_len MIN_CONTIG_LEN]
                         [--min_contig_depth MIN_CONTIG_DEPTH]
                         [--distance DISTANCE] [-t THREADS] [-h] [--version]

cluster contigs by similarity

Required arguments:
  -a ASSEMBLIES [ASSEMBLIES ...], --assemblies ASSEMBLIES [ASSEMBLIES ...]
                          Input assemblies whose contigs will be clustered
                          (multiple FASTA files)
  -r READS, --reads READS
                          Long reads (FASTQ format) used to generate the
                          assemblies
  -o OUT_DIR, --out_dir OUT_DIR
                          Output directory

Settings:
  --min_contig_len MIN_CONTIG_LEN
                          Exclude contigs shorter than this many base pairs in
                          length (default: 1000)
  --min_contig_depth MIN_CONTIG_DEPTH
                          Exclude contigs with less than this much read depth
                          relative to the mean read depth (default: 0.1)
  --distance DISTANCE     Mash distance complete-linkage clustering threshold
                          (default: 0.01)
  -t THREADS, --threads THREADS
                          Number of threads to use for alignment (default: 16)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## trycycler_dotplot

### Tool Description
draw pairwise dotplots for a cluster

### Metadata
- **Docker Image**: quay.io/biocontainers/trycycler:0.5.6--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Trycycler
- **Package**: https://anaconda.org/channels/bioconda/packages/trycycler/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: trycycler dotplot -c CLUSTER_DIR [--kmer KMER] [--res RES] [-h]
                         [--version]

draw pairwise dotplots for a cluster

Required arguments:
  -c CLUSTER_DIR, --cluster_dir CLUSTER_DIR
                          Cluster directory (should contain a 1_contigs
                          subdirectory)

Settings:
  --kmer KMER             K-mer size to use in dot plots (default: 32)
  --res RES               Size (in pixels) of each dot plot image (default:
                          2000)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## trycycler_reconcile

### Tool Description
reconcile contig sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/trycycler:0.5.6--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Trycycler
- **Package**: https://anaconda.org/channels/bioconda/packages/trycycler/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: trycycler reconcile -c CLUSTER_DIR -r READS [--linear] [-t THREADS]
                           [--verbose] [--max_mash_dist MAX_MASH_DIST]
                           [--max_length_diff MAX_LENGTH_DIFF]
                           [--max_add_seq MAX_ADD_SEQ]
                           [--max_add_seq_percent MAX_ADD_SEQ_PERCENT]
                           [--max_trim_seq MAX_TRIM_SEQ]
                           [--max_trim_seq_percent MAX_TRIM_SEQ_PERCENT]
                           [--min_identity MIN_IDENTITY]
                           [--min_1kbp_identity MIN_1KBP_IDENTITY] [-h]
                           [--version]

reconcile contig sequences

Required arguments:
  -c CLUSTER_DIR, --cluster_dir CLUSTER_DIR
                          Cluster directory (should contain a 1_contigs
                          subdirectory)
  -r READS, --reads READS
                          Long reads (FASTQ format) used to generate the
                          assemblies

Settings:
  --linear                The input contigs are not circular (default: assume
                          the input contigs are circular)
  -t THREADS, --threads THREADS
                          Number of threads to use for alignment (default: 16)
  --verbose               Display extra output (for debugging) (default:
                          False)

Initial check:
  --max_mash_dist MAX_MASH_DIST
                          Maximum allowed pairwise Mash distance (default:
                          0.02)
  --max_length_diff MAX_LENGTH_DIFF
                          Maximum allowed pairwise relative length difference
                          (default: 1.1)

Circularisation:
  --max_add_seq MAX_ADD_SEQ
                          Maximum allowed sequence length to be added in order
                          to fix circularisation (default: 1000)
  --max_add_seq_percent MAX_ADD_SEQ_PERCENT
                          Maximum allowed percent relative sequence length to
                          be added in order to fix circularisation (default:
                          5.0)
  --max_trim_seq MAX_TRIM_SEQ
                          Maximum allowed sequence length to be trimmed in
                          order to fix circularisation (default: 50000)
  --max_trim_seq_percent MAX_TRIM_SEQ_PERCENT
                          Maximum allowed percent relative sequence length to
                          be trimmed in order to fix circularisation (default:
                          10.0)

Final check:
  --min_identity MIN_IDENTITY
                          Minimum allowed pairwise percent identity (default:
                          98.0)
  --min_1kbp_identity MIN_1KBP_IDENTITY
                          Minimum allowed pairwise 1kbp window identity
                          (default: 25.0)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## trycycler_msa

### Tool Description
multiple sequence alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/trycycler:0.5.6--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Trycycler
- **Package**: https://anaconda.org/channels/bioconda/packages/trycycler/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: trycycler msa -c CLUSTER_DIR [-k KMER] [-s STEP] [-l LOOKAHEAD]
                     [-t THREADS] [-h] [--version]

multiple sequence alignment

Required arguments:
  -c CLUSTER_DIR, --cluster_dir CLUSTER_DIR
                          Cluster directory (should contain a 1_contigs
                          subdirectory)

Settings:
  -k KMER, --kmer KMER    K-mer size used for sequence partitioning (default:
                          32)
  -s STEP, --step STEP    Step size used for sequence partitioning (default:
                          1000)
  -l LOOKAHEAD, --lookahead LOOKAHEAD
                          Look-ahead margin used for sequence partitioning
                          (default: 10000)
  -t THREADS, --threads THREADS
                          Number of threads to use for multiple sequence
                          alignment (default: 16)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## trycycler_partition

### Tool Description
partition reads by cluster

### Metadata
- **Docker Image**: quay.io/biocontainers/trycycler:0.5.6--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Trycycler
- **Package**: https://anaconda.org/channels/bioconda/packages/trycycler/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: trycycler partition -c CLUSTER_DIRS [CLUSTER_DIRS ...] -r READS
                           [--min_aligned_len MIN_ALIGNED_LEN]
                           [--min_read_cov MIN_READ_COV] [-t THREADS] [-h]
                           [--version]

partition reads by cluster

Required arguments:
  -c CLUSTER_DIRS [CLUSTER_DIRS ...], --cluster_dirs CLUSTER_DIRS [CLUSTER_DIRS ...]
                          Cluster directories (each should contain
                          2_all_seqs.fasta and 3_pairwise_alignments files)
  -r READS, --reads READS
                          Long reads (FASTQ format) used to generate the
                          assemblies

Settings:
  --min_aligned_len MIN_ALIGNED_LEN
                          Do not consider reads with less than this many bases
                          aligned (default: 1000)
  --min_read_cov MIN_READ_COV
                          Do not consider reads with less than this
                          percentages of their length covered by alignments
                          (default: 90.0)
  -t THREADS, --threads THREADS
                          Number of threads to use for alignment (default: 16)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## trycycler_consensus

### Tool Description
derive a consensus sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/trycycler:0.5.6--pyhdfd78af_0
- **Homepage**: https://github.com/rrwick/Trycycler
- **Package**: https://anaconda.org/channels/bioconda/packages/trycycler/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: trycycler consensus -c CLUSTER_DIR [--linear]
                           [--min_aligned_len MIN_ALIGNED_LEN]
                           [--min_read_cov MIN_READ_COV] [-t THREADS]
                           [--verbose] [-h] [--version]

derive a consensus sequence

Required arguments:
  -c CLUSTER_DIR, --cluster_dir CLUSTER_DIR
                          Cluster directory (should contain 2_all_seqs.fasta,
                          3_pairwise_alignments and 4_reads.fastq files)

Settings:
  --linear                The input contigs are not circular (default: assume
                          the input contigs are circular)
  --min_aligned_len MIN_ALIGNED_LEN
                          Do not consider reads with less than this many bases
                          aligned (default: 1000)
  --min_read_cov MIN_READ_COV
                          Do not consider reads with less than this
                          percentages of their length covered by alignments
                          (default: 90.0)
  -t THREADS, --threads THREADS
                          Number of threads to use for alignment (default: 16)
  --verbose               Display extra output (for debugging) (default:
                          False)

Other:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


## Metadata
- **Skill**: generated
