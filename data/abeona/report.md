# abeona CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| abeona_assemble | PASS |  |
| abeona_reads | PASS |  |
| abeona_subgraphs | PASS |  |

## abeona_assemble

### Tool Description
Run abeona assembly pipeline (Nextflow): build a cortex De Bruijn graph from reads, split it into subgraphs, create candidate transcripts and filter them with kallisto.

### Metadata
- **Docker Image**: quay.io/biocontainers/abeona:0.45.0--py36_0
- **Homepage**: https://github.com/winni2k/abeona
- **Package**: https://anaconda.org/channels/bioconda/packages/abeona/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/abeona/overview
- **Total Downloads**: 87.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/winni2k/abeona
- **Stars**: 2
### Original Help Text
```text
usage: abeona assemble [-h] -o OUT_DIR [-j JOBS] [-k KMER_SIZE] [-m MEMORY]
                       [-q] [--resume] [--no-cleanup] [--with-report]
                       [--with-dag] [--fastx-forward FASTX_FORWARD]
                       [--fastx-reverse FASTX_REVERSE]
                       [--fastx-single FASTX_SINGLE]
                       [--initial-contigs INITIAL_CONTIGS]
                       [--extra-start-kmer EXTRA_START_KMER]
                       [--min-tip-length MIN_TIP_LENGTH]
                       [--min-unitig-coverage MIN_UNITIG_COVERAGE]
                       [--no-prune-tips-with-mccortex]
                       [--prune-tips-with-mccortex] [--prune-tips-iteratively]
                       [--max-paths-per-subgraph MAX_PATHS_PER_SUBGRAPH]
                       [--no-links] [--report-unassembled-reads]
                       [--assemble-unassembled-reads-with-transabyss]
                       [--bootstrap-samples BOOTSTRAP_SAMPLES]
                       [--kallisto-fragment-length KALLISTO_FRAGMENT_LENGTH]
                       [--kallisto-sd KALLISTO_SD]
                       [--kallisto-threads KALLISTO_THREADS]
                       [--max-read-length MAX_READ_LENGTH]
                       [--estimated-count-threshold ESTIMATED_COUNT_THRESHOLD]
                       [--bootstrap-proportion-threshold BOOTSTRAP_PROPORTION_THRESHOLD]
                       [--record-buffer-size RECORD_BUFFER_SIZE]
                       [--max-junctions MAX_JUNCTIONS]

Run abeona assembly pipeline.

optional arguments:
  -h, --help            show this help message and exit
  -o OUT_DIR, --out-dir OUT_DIR
                        Output directory (default: None)
  -j JOBS, --jobs JOBS  Number of jobs to schedule concurrently (default: 2)
  -k KMER_SIZE, --kmer-size KMER_SIZE
                        k-mer size to use to construct the De Bruijn graph
                        (default: 47)
  -m MEMORY, --memory MEMORY
                        Maximum memory to use in giga bytes (default: 3)
  -q, --quiet
  --resume
  --no-cleanup
  --with-report         Create nextflow report file at nexttflow_report.html
                        in output directory (default: False)
  --with-dag            Create flowchart of workflow at flowchart.png in
                        output directory (default: False)
  --fastx-forward FASTX_FORWARD
                        Forward sequences in FASTA/FASTQ format (default:
                        None)
  --fastx-reverse FASTX_REVERSE
                        Reverse sequences in FASTA/FASTQ format (default:
                        None)
  --fastx-single FASTX_SINGLE
                        Single-end sequences in FASTA/FASTQ format (default:
                        None)
  --initial-contigs INITIAL_CONTIGS
                        Only start assembly from contigs in this FASTA
                        (default: None)
  --extra-start-kmer EXTRA_START_KMER
                        Disconnect this k-mer from incoming k-mers before
                        candidate transcript creation. This may be useful when
                        assembling circular genomes. Best used with --initial-
                        contigs to make sure the k-mer exists in the
                        consistent cortexpy graph. (default: None)

Graph traversal cleaning:
  --min-tip-length MIN_TIP_LENGTH
                        Prune tips shorter than this value. A value of -1 sets
                        the min tip length to the value of --kmer-size
                        (default: -1)
  --min-unitig-coverage MIN_UNITIG_COVERAGE
                        Prune unitigs with mean coverage below this value
                        (default: 4)
  --no-prune-tips-with-mccortex
                        Instead of Mccortex use cortexpy to prune unitigs.
                        This is slower and not recommended at this time.
                        (default: False)
  --prune-tips-with-mccortex
  --prune-tips-iteratively
                        Prune the graph of tip lengths x = 2^n while x is less
                        than --min-tip-length. Finally, prune graph of tips
                        shorter than --min-tip-length. Currently only works
                        when pruning with Mccortex. (default: False)

Candidate transcript creation:
  --max-paths-per-subgraph MAX_PATHS_PER_SUBGRAPH
                        Ignore graphs that have more than this number of paths
                        (default: 0)
  --no-links            Do not use links in candidate transcript creation
                        (default: False)
  --report-unassembled-reads
                        Store reads from ignored graphs in unassembled_reads
                        (default: False)
  --assemble-unassembled-reads-with-transabyss
                        Try and assemble reads from ignored graphs with
                        transabyss (default: False)

kallisto arguments:
  Arguments passed directly on to kallisto

  --bootstrap-samples BOOTSTRAP_SAMPLES
                        Number of kallisto bootstrap samples (default: 100)
  --kallisto-fragment-length KALLISTO_FRAGMENT_LENGTH
  --kallisto-sd KALLISTO_SD
  --kallisto-threads KALLISTO_THREADS
                        Number of logical cores to assign to a single kallisto
                        quant job. Needs to be less than or equal to --jobs
                        (default: 2)
  --max-read-length MAX_READ_LENGTH
                        Length of longest read in data. Remove candidate
                        subgraphs that do not have at least one candidate
                        transcript greater than this length. Kallisto cannot
                        align reads to transcripts that are shorter than the
                        read. If this value is not specified, then abeona
                        estimates this value from the head of the reads
                        supplied to kallisto (--kallisto-fastx-*). (default:
                        None)

Candidate transcript filtering:
  --estimated-count-threshold ESTIMATED_COUNT_THRESHOLD
                        Threshold over which the estimated transcript count
                        from kallisto is counted towards keeping a transcript
                        (default: 1)
  --bootstrap-proportion-threshold BOOTSTRAP_PROPORTION_THRESHOLD
                        Proportion of bootstrap iterations for which a
                        transcript's estimated counts must be above the
                        --estimated-count-threshold (default: 0.95)
  --record-buffer-size RECORD_BUFFER_SIZE
                        Number of reads to buffer in memory when assigning
                        reads to subgraphs (default: -1)
  --max-junctions MAX_JUNCTIONS
                        The max junctions argument can be used to quickly
                        ignore large subgraphs with too many junctions to
                        process effectively. (default: 0)
```


## abeona_reads

### Tool Description
Assign reads to cortex graphs.

### Metadata
- **Docker Image**: quay.io/biocontainers/abeona:0.45.0--py36_0
- **Homepage**: https://github.com/winni2k/abeona
- **Package**: https://anaconda.org/channels/bioconda/packages/abeona/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/abeona/overview
- **Total Downloads**: 87.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/winni2k/abeona
- **Stars**: 2
### Original Help Text
```text
usage: abeona reads [-h] [--reverse REVERSE] --format {fasta,fastq}
                    [--record-buffer-size RECORD_BUFFER_SIZE]
                    graph_list forward

Assign reads to cortex graphs.

positional arguments:
  graph_list            Tab delimited text file with two columns and optional
                        header line. All lines starting with '#' are ignored.
                        For example: ``` # prefix graph out_dir/g1 g1.ctx
                        out_dir/g2 g2.ctx ```
  forward               Forward reads file in FASTA or FASTQ format.

optional arguments:
  -h, --help            show this help message and exit
  --reverse REVERSE     Reverse reads file in FASTA or FASTQ format. Only
                        specified if reads are paired
  --format {fasta,fastq}
                        File format of input reads.
  --record-buffer-size RECORD_BUFFER_SIZE
                        Flush all reads to disk after this many records have
                        been assigned
```


## abeona_subgraphs

### Tool Description
Partition cortex graph into its subgraphs.

### Metadata
- **Docker Image**: quay.io/biocontainers/abeona:0.45.0--py36_0
- **Homepage**: https://github.com/winni2k/abeona
- **Package**: https://anaconda.org/channels/bioconda/packages/abeona/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/abeona/overview
- **Total Downloads**: 87.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/winni2k/abeona
- **Stars**: 2
### Original Help Text
```text
usage: abeona subgraphs [-h] [-m MEMORY] [-c CORES]
                        [--initial-contigs INITIAL_CONTIGS]
                        graph out_dir

Partition cortex graph into its subgraphs.

positional arguments:
  graph
  out_dir

optional arguments:
  -h, --help            show this help message and exit
  -m MEMORY, --memory MEMORY
  -c CORES, --cores CORES
  --initial-contigs INITIAL_CONTIGS
                        Only start assembly from contigs in this FASTA
```


## Metadata
- **Skill**: generated
