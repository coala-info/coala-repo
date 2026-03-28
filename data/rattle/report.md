# rattle CWL Generation Report

## rattle_cluster

### Tool Description
Rattlesnake clustering tool

### Metadata
- **Docker Image**: quay.io/biocontainers/rattle:1.0--h5ca1c30_0
- **Homepage**: https://github.com/comprna/RATTLE
- **Package**: https://anaconda.org/channels/bioconda/packages/rattle/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rattle/overview
- **Total Downloads**: 706
- **Last updated**: 2025-11-27
- **GitHub**: https://github.com/comprna/RATTLE
- **Stars**: N/A
### Original Help Text
```text
ERROR: No input file provided
    -h, --help
        shows this help message
    -i, --input
        input fasta/fastq file (required)
    -l, --label
        labels for the files in order of entry
    -o, --output
        output folder (default: .)
    -t, --threads
        number of threads to use (default: 1)
    -k, --kmer-size
        k-mer size for gene clustering (default: 10, maximum: 16)
    -s, --score-threshold
        minimum score for two reads to be in the same gene cluster (default: 0.2)
    -v, --max-variance
        max allowed variance for two reads to be in the same gene cluster (default: 1000000)
    --iso
        perform clustering at the isoform level
    --iso-kmer-size
        k-mer size for isoform clustering (default: 11, maximum: 16)
    --iso-score-threshold
        minimum score for two reads to be in the same isoform cluster (default: 0.3)
    --iso-max-variance
        max allowed variance for two reads to be in the same isoform cluster (default: 25)
    -B, --bv-start-threshold
        starting threshold for the bitvector k-mer comparison (default: 0.4)
    -b, --bv-end-threshold
        ending threshold for the bitvector k-mer comparison (default: 0.2)
    -f, --bv-falloff
        falloff value for the bitvector threshold for each iteration (default: 0.05)
    -r, --min-reads-cluster
        minimum number of reads per cluster (default: 0)
    -p, --repr-percentile
        cluster representative percentile (default: 0.15)
    --rna
        use this mode if data is direct RNA (disables checking both strands)
    --verbose
        use this flag if need to print the progress
    --raw
        use this flag if want to use raw datasets
    --lower-length
        set the lower length for input reads filter (default: 150)
    --upper-length
        set the upper length for input reads filter (default: 100,000)
```


## rattle_cluster_summary

### Tool Description
Generates a summary of clustering results from input FASTA/FASTQ and cluster files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rattle:1.0--h5ca1c30_0
- **Homepage**: https://github.com/comprna/RATTLE
- **Package**: https://anaconda.org/channels/bioconda/packages/rattle/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: No input file provided
    -h, --help
        shows this help message
    -i, --input
        input fasta/fastq file (required)
    -l, --label
        labels for the files in order of entry
    -c, --clusters
        clusters file (required)
```


## rattle_extract_clusters

### Tool Description
Extracts clusters from a fasta/fastq file based on a clusters file.

### Metadata
- **Docker Image**: quay.io/biocontainers/rattle:1.0--h5ca1c30_0
- **Homepage**: https://github.com/comprna/RATTLE
- **Package**: https://anaconda.org/channels/bioconda/packages/rattle/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: No input file provided
    -h, --help
        shows this help message
    -i, --input
        input fasta/fastq file (required)
    -l, --label
        labels for the files in order of entry
    -c, --clusters
        clusters file (required)
    -o, --output-folder
        output folder for fastx files (default: .)
    -m, --min-reads
        min reads per cluster to save it into a file
    --fastq
        whether input and output should be in fastq format (instead of fasta)
```


## rattle_correct

### Tool Description
Corrects errors in fasta/fastq files based on cluster information.

### Metadata
- **Docker Image**: quay.io/biocontainers/rattle:1.0--h5ca1c30_0
- **Homepage**: https://github.com/comprna/RATTLE
- **Package**: https://anaconda.org/channels/bioconda/packages/rattle/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: No input file provided
    -h, --help
        shows this help message
    -i, --input
        input fasta/fastq file (required)
    -l, --label
        labels for the files in order of entry
    -c, --clusters
        clusters file (required)
    -o, --output
        output folder (default: .)
    -g, --gap-occ
        gap-occ (default: 0.3)
    -m, --min-occ
        min-occ (default: 0.3)
    -s, --split
        split clusters into sub-clusters of size s for msa (default: 200)
    -r, --min-reads
        min reads to correct/output consensus for a cluster (default: 5)
    -t, --threads
        number of threads to use (default: 1)
    --verbose
        use this flag if need to print the progress
```


## rattle_polish

### Tool Description
RATTLE Polish

### Metadata
- **Docker Image**: quay.io/biocontainers/rattle:1.0--h5ca1c30_0
- **Homepage**: https://github.com/comprna/RATTLE
- **Package**: https://anaconda.org/channels/bioconda/packages/rattle/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: No input file provided
    -h, --help
        shows this help message
    -i, --input
        input RATTLE consensi fasta/fastq file (required)
    -o, --output-folder
        output folder for fastx files (default: .)
    -l, --label
        labels for the files in order of entry
    -t, --threads
        number of threads to use (default: 1)
    --rna
        use this mode if data is direct RNA (disables checking both strands)
    --verbose
        use this flag if need to print the progress
    --summary
        use this flag to print a summary of transcript/gene clusters used to genearte the transcriptome
```


## Metadata
- **Skill**: generated
