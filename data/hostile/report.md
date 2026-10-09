# hostile CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hostile_clean | PASS |  |
| hostile_index_fetch | PASS |  |
| hostile_index_list | PASS |  |
| hostile_mask | PASS |  |

## hostile_clean

### Tool Description
Remove reads aligning to an index from fastq[.gz] input files or stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/hostile:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/bede/hostile
- **Package**: https://anaconda.org/channels/bioconda/packages/hostile/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hostile/overview
- **Total Downloads**: 15.2K
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/bede/hostile
- **Stars**: N/A
### Original Help Text
```text
usage: hostile clean [-h] --fastq1 FASTQ1 [--fastq2 FASTQ2]
                     [--aligner {bowtie2,minimap2,auto}] [--index INDEX]
                     [--invert] [--rename] [--reorder] [-c] [-o OUTPUT]
                     [--aligner-args ALIGNER_ARGS] [-t THREADS] [--force]
                     [--airplane] [-d]

Remove reads aligning to an index from fastq[.gz] input files or stdin.

options:
  -h, --help            show this help message and exit
  --fastq1 FASTQ1       path to forward fastq[.gz] file or - for stdin
  --fastq2 FASTQ2       optional path to reverse fastq[.gz] file or - for stdin
                        (default: )
  --aligner {bowtie2,minimap2,auto}
                        alignment algorithm. Defaults to minimap2 (long read) given fastq1 only or bowtie2 (short read)
                        given fastq1 and fastq2. Override with bowtie2 for single/unpaired short reads
                        (default: auto)
  --index INDEX         name of standard index or path to custom genome (Minimap2) or Bowtie2 index
                        (default: human-t2t-hla)
  --invert              keep only reads aligning to the index (and their mates if applicable)
                        (default: False)
  --rename              replace read names with incrementing integers
                        (default: False)
  --reorder             ensure deterministic output order
                        (default: False)
  -c, --casava          use Casava 1.8+ read header format
                        (default: False)
  -o, --output OUTPUT   path to output directory or - for stdout
                        (default: /)
  --aligner-args ALIGNER_ARGS
                        additional arguments for alignment
                        (default: )
  -t, --threads THREADS
                        number of alignment threads. A sensible default is chosen automatically
                        (default: 20)
  --force               overwrite existing output files
                        (default: False)
  --airplane            disable automatic index download (offline mode)
                        (default: False)
  -d, --debug           show debug messages
                        (default: False)
```


## hostile_mask

### Tool Description
Mask reference genome against target genome(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/hostile:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/bede/hostile
- **Package**: https://anaconda.org/channels/bioconda/packages/hostile/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hostile mask [-h] [-o OUTPUT] [--kmer-length KMER_LENGTH]
                    [--kmer-step KMER_STEP] [-t THREADS]
                    reference target

Mask reference genome against target genome(s)

positional arguments:
  reference             path to reference genome in fasta(.gz) format
  target                path to target genome(s) in fasta(.gz) format

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   path to output directory
                        (default: masked)
  --kmer-length KMER_LENGTH
                        length of target genome k-mers
                        (default: 150)
  --kmer-step KMER_STEP
                        interval between target genome k-mer start positions
                        (default: 10)
  -t, --threads THREADS
                        number of threads to use
                        (default: 20)
```


## hostile_index_list

### Tool Description
List available remote and local cached indexes

### Metadata
- **Docker Image**: quay.io/biocontainers/hostile:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/bede/hostile
- **Package**: https://anaconda.org/channels/bioconda/packages/hostile/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hostile index list [-h] [-a]

List available remote and local cached indexes

options:
  -h, --help      show this help message and exit
  -a, --airplane  list only local cached indexes (offline mode)
                  (default: False)
```

## hostile_index_fetch

### Tool Description
Download and cache indexes from object storage for use with hostile clean

### Metadata
- **Docker Image**: quay.io/biocontainers/hostile:2.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/bede/hostile
- **Package**: https://anaconda.org/channels/bioconda/packages/hostile/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hostile index fetch [-h] [-n NAME] [-m] [-b]

Download and cache indexes from object storage for use with hostile clean

options:
  -h, --help       show this help message and exit
  -n, --name NAME  name of index to download
                   (default: human-t2t-hla)
  -m, --minimap2   fetch Minimap2 index
                   (default: False)
  -b, --bowtie2    fetch Bowtie2 index
                   (default: False)
```

## Metadata
- **Skill**: generated
