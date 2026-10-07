# dbcan CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| dbcan_CAZyme_annotation | PASS |  |
| dbcan_Pfam_null_cgc | Not completed | Needs CGC finder results and the Pfam-A HMM database, too large for this test. |
| dbcan_cgc_circle_plot | Not completed | Needs CGC finder results, which need the large CGC databases. |
| dbcan_cgc_finder | Not completed | Needs cgc.gff from gff_process, which needs the large CGC databases; with only CAZyme results it exits 0 and writes nothing. |
| dbcan_database | Not completed | Downloads several GB of dbCAN databases, too large for this test. |
| dbcan_easy_CGC | Not completed | Needs the full dbCAN database set (CAZy.dmnd 2.2 GB plus CGC databases), too large for this test. |
| dbcan_easy_substrate | Not completed | Needs the full dbCAN database set (several GB), too large for this test. |
| dbcan_gff_process | Not completed | Needs the CGC databases (peptidase 333 MB, SulfAtlas 103 MB, TCDB, TF, STP), too large for this test. |
| dbcan_substrate_prediction | Not completed | Needs CGC results plus the dbCAN-sub (2.4 GB) and dbCAN-PUL databases. |

## dbcan_CAZyme_annotation

### Tool Description
annotate CAZyme using run_dbcan with prokaryotic, metagenomics, and protein sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
- **Homepage**: http://bcb.unl.edu/dbCAN2/
- **Package**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Total Downloads**: 25.8K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/linnabrown/run_dbcan
- **Stars**: N/A
### Original Help Text
```text
 Usage: run_dbcan CAZyme_annotation [OPTIONS]

 annotate CAZyme using run_dbcan with prokaryotic, metagenomics, and protein sequences.

╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│    --verbose                                                             -v                                       Enable verbose logging (equivalent to --log-level DEBUG)                                                         │
│    --log-file                                                                PATH                                 Write logs to file in addition to console                                                                        │
│    --log-level                                                               [DEBUG|INFO|WARNING|ERROR|CRITICAL]  Set logging level (default: WARNING, only shows warnings and errors)                                             │
│ *  --mode                                                                    TEXT                                 Mode of input sequence [required]                                                                                │
│ *  --output_dir                                                              TEXT                                 Directory for the output files [required]                                                                        │
│ *  --input_raw_data                                                          TEXT                                 Path to the input raw data [required]                                                                            │
│ *  --db_dir                                                                  TEXT                                 Directory for the database [required]                                                                            │
│    --methods                                                                 METHODS                              Specify the annotation methods to use (comma-separated). Options: diamond, hmm, dbCANsub. Example: --methods     │
│                                                                                                                   diamond,hmm or --methods hmm [default: diamond,hmm,dbCANsub]                                                     │
│    --threads                                                                 INTEGER                              Number of threads                                                                                                │
│    --verbose_option                                                                                               Enable verbose option for diamond                                                                                │
│    --e_value_threshold                                                       FLOAT                                E-value threshold for diamond                                                                                    │
│    --large_input_threshold_mb                                                INTEGER                              Auto-enable large mode when input fasta size exceeds this threshold (MB). [default: 5000]                        │
│    --large/--no-large                                                                                             Enable streaming-safe mode for very large inputs (reduces OOM risk). [default: no-large]                         │
│    --enable_memory_monitoring/--no-enable_memory_monitoring                                                       Enable memory monitoring and adaptive throttling for pyhmmer. [default: enable_memory_monitoring]                │
│    --max_retries                                                             INTEGER                              Maximum retries on OOM during pyhmmer search. [default: 3]                                                       │
│    --memory_safety_factor                                                    FLOAT                                Safety factor for auto batch size (0.0-1.0, smaller = safer). [default: 0.5]                                     │
│    --max_memory_usage                                                        FLOAT                                Maximum system memory usage ratio before warnings/throttling (0.0-1.0). [default: 0.8]                           │
│    --batch_size                                                              INTEGER                              Process this many sequences per batch in pyhmmer (None = auto).                                                  │
│    --csv_buffer_size                                                         INTEGER                              Flush this many HMM hits to disk at once (larger can be faster, uses a bit more RAM). [default: 5000]            │
│    --coverage_threshold_dbcan                                                FLOAT                                Coverage threshold for dbCAN HMMER                                                                               │
│    --e_value_threshold_dbcan                                                 FLOAT                                E-value threshold for dbCAN HMMER                                                                                │
│    --large_input_threshold_mb_dbsub                                          INTEGER                              (dbCAN-sub) Auto-enable large mode when input fasta exceeds this threshold (MB). [default: 5000]                 │
│    --large_dbsub/--no-large_dbsub                                                                                 (dbCAN-sub) Enable streaming-safe mode for very large inputs. [default: no-large_dbsub]                          │
│    --enable_memory_monitoring_dbsub/--no-enable_memory_monitoring_dbsub                                           (dbCAN-sub) Enable memory monitoring and adaptive throttling for pyhmmer. [default:                              │
│                                                                                                                   enable_memory_monitoring_dbsub]                                                                                  │
│    --max_retries_dbsub                                                       INTEGER                              (dbCAN-sub) Maximum retries on OOM during pyhmmer search. [default: 3]                                           │
│    --memory_safety_factor_dbsub                                              FLOAT                                (dbCAN-sub) Safety factor for auto batch size (0.0-1.0). [default: 0.5]                                          │
│    --max_memory_usage_dbsub                                                  FLOAT                                (dbCAN-sub) Maximum system memory usage ratio before warnings/throttling (0.0-1.0). [default: 0.8]               │
│    --batch_size_dbsub                                                        INTEGER                              (dbCAN-sub) Sequences per batch in pyhmmer (None = auto).                                                        │
│    --csv_buffer_size_dbsub                                                   INTEGER                              (dbCAN-sub) Flush this many HMM hits to disk at once. [default: 5000]                                            │
│    --coverage_threshold_dbsub                                                FLOAT                                Coverage threshold for dbCAN-sub HMMER                                                                           │
│    --e_value_threshold_dbsub                                                 FLOAT                                E-value threshold for dbCAN-sub HMMER                                                                            │
│    --force_topology/--no-force_topology                                                                           Overwrite existing SignalP columns instead of only filling empty cells                                           │
│    --signalp_org                                                             [other|euk]                          Organism type passed to SignalP6 [default: other]                                                                │
│    --run_signalp/--no-run_signalp                                                                                 Run SignalP6.0 (biolib) to predict signal peptides for all proteins in overview                                  │
│    --help                                                                                                         Show this message and exit.                                                                                      │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## dbcan_Pfam_null_cgc

### Tool Description
identify CAZyme Gene Clusters(CGCs)

### Metadata
- **Docker Image**: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
- **Homepage**: http://bcb.unl.edu/dbCAN2/
- **Package**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Total Downloads**: 25.8K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/linnabrown/run_dbcan
- **Stars**: N/A
### Original Help Text
```text
 Usage: run_dbcan Pfam_null_cgc [OPTIONS]

 identify CAZyme Gene Clusters(CGCs)

╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│    --verbose                  -v                                       Enable verbose logging (equivalent to --log-level DEBUG)                                                                                                    │
│    --log-file                     PATH                                 Write logs to file in addition to console                                                                                                                   │
│    --log-level                    [DEBUG|INFO|WARNING|ERROR|CRITICAL]  Set logging level (default: WARNING, only shows warnings and errors)                                                                                        │
│    --threads                      INTEGER                              Number of threads                                                                                                                                           │
│ *  --db_dir                       TEXT                                 Directory for the database [required]                                                                                                                       │
│ *  --output_dir                   TEXT                                 Directory for the output files [required]                                                                                                                   │
│    --null_from_gff                                                     Extract null genes from cgc.gff instead of cgc_standard_out.tsv                                                                                             │
│    --coverage_threshold_pfam      FLOAT                                Coverage threshold for Pfam HMMER                                                                                                                           │
│    --e_value_threshold_pfam       FLOAT                                E-value threshold for Pfam HMMER                                                                                                                            │
│    --run_pfam                                                          Run Pfam HMMER for CGC null gene annotation                                                                                                                 │
│    --help                                                              Show this message and exit.                                                                                                                                 │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## dbcan_cgc_circle_plot

### Tool Description
generate circular plots for CAZyme Gene Clusters(CGCs).

### Metadata
- **Docker Image**: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
- **Homepage**: http://bcb.unl.edu/dbCAN2/
- **Package**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Total Downloads**: 25.8K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/linnabrown/run_dbcan
- **Stars**: N/A
### Original Help Text
```text
 Usage: run_dbcan cgc_circle_plot [OPTIONS]

 generate circular plots for CAZyme Gene Clusters(CGCs).

╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│    --verbose     -v                                       Enable verbose logging (equivalent to --log-level DEBUG)                                                                                                                 │
│    --log-file        PATH                                 Write logs to file in addition to console                                                                                                                                │
│    --log-level       [DEBUG|INFO|WARNING|ERROR|CRITICAL]  Set logging level (default: WARNING, only shows warnings and errors)                                                                                                     │
│ *  --output_dir      TEXT                                 Directory for the output files [required]                                                                                                                                │
│    --help                                                 Show this message and exit.                                                                                                                                              │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## dbcan_cgc_finder

### Tool Description
identify CAZyme Gene Clusters(CGCs)

### Metadata
- **Docker Image**: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
- **Homepage**: http://bcb.unl.edu/dbCAN2/
- **Package**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Total Downloads**: 25.8K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/linnabrown/run_dbcan
- **Stars**: N/A
### Original Help Text
```text
 Usage: run_dbcan cgc_finder [OPTIONS]

 identify CAZyme Gene Clusters(CGCs)

╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│    --verbose                             -v                                       Enable verbose logging (equivalent to --log-level DEBUG)                                                                                         │
│    --log-file                                PATH                                 Write logs to file in addition to console                                                                                                        │
│    --log-level                               [DEBUG|INFO|WARNING|ERROR|CRITICAL]  Set logging level (default: WARNING, only shows warnings and errors)                                                                             │
│ *  --output_dir                              TEXT                                 Directory for the output files [required]                                                                                                        │
│    --feature_type                            TEXT                                 GFF feature types to include (multiple allowed).                                                                                                 │
│    --min_cluster_genes                       INTEGER                              Minimum number of genes required per CGC.                                                                                                        │
│    --min_core_cazyme                         INTEGER                              Minimum number of core CAZymes required per CGC.                                                                                                 │
│    --extend_gene_count                       INTEGER                              When --extend_mode=gene, extend this many genes on each side.                                                                                    │
│    --extend_bp                               INTEGER                              When --extend_mode=bp, extend this many base pairs on each side.                                                                                 │
│    --extend_mode                             [none|bp|gene]                       Extend CGC region on both sides after identification. 'bp' extends by base pairs; 'gene' extends by gene count; 'none' disables extension.       │
│    --use_distance                                                                 Use base pair distance in CGC annotation.                                                                                                        │
│    --use_null_genes/--no-use_null_genes                                           Use null genes in CGC annotation.                                                                                                                │
│    --base_pair_distance                      INTEGER                              Base pair distance of signature genes.                                                                                                           │
│    --num_null_gene                           INTEGER                              Maximum number of null genes allowed between signature genes.                                                                                    │
│    --additional_min_categories               INTEGER                              When --additional_logic=any, require at least this number of distinct additional categories.                                                     │
│    --additional_logic                        [all|any]                            Logic for multiple --additional_genes: 'all' requires all present; 'any' requires at least one.                                                  │
│    --additional_genes                        TEXT                                 Specify additional gene types for CGC annotation, including TC, TF, and STP                                                                      │
│    --help                                                                         Show this message and exit.                                                                                                                      │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## dbcan_database

### Tool Description
download dbCAN databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
- **Homepage**: http://bcb.unl.edu/dbCAN2/
- **Package**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Total Downloads**: 25.8K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/linnabrown/run_dbcan
- **Stars**: N/A
### Original Help Text
```text
 Usage: run_dbcan database [OPTIONS]

 download dbCAN databases.

╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│    --verbose       -v                                       Enable verbose logging (equivalent to --log-level DEBUG)                                                                                                               │
│    --log-file          PATH                                 Write logs to file in addition to console                                                                                                                              │
│    --log-level         [DEBUG|INFO|WARNING|ERROR|CRITICAL]  Set logging level (default: WARNING, only shows warnings and errors)                                                                                                   │
│    --aws_s3                                                 Download databases from AWS S3                                                                                                                                         │
│    --cgc/--no-cgc                                           Enable CGC-related databases (database download only)                                                                                                                  │
│ *  --db_dir            TEXT                                 Directory for the database [required]                                                                                                                                  │
│    --help                                                   Show this message and exit.                                                                                                                                            │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## dbcan_easy_CGC

### Tool Description
Perform complete CGC analysis: CAZyme annotation, GFF processing, and CGC identification in one step.

### Metadata
- **Docker Image**: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
- **Homepage**: http://bcb.unl.edu/dbCAN2/
- **Package**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Total Downloads**: 25.8K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/linnabrown/run_dbcan
- **Stars**: N/A
### Original Help Text
```text
 Usage: run_dbcan easy_CGC [OPTIONS]

 Perform complete CGC analysis: CAZyme annotation, GFF processing, and CGC identification in one step.

╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│    --verbose                                                             -v                                       Enable verbose logging (equivalent to --log-level DEBUG)                                                         │
│    --log-file                                                                PATH                                 Write logs to file in addition to console                                                                        │
│    --log-level                                                               [DEBUG|INFO|WARNING|ERROR|CRITICAL]  Set logging level (default: WARNING, only shows warnings and errors)                                             │
│ *  --mode                                                                    TEXT                                 Mode of input sequence [required]                                                                                │
│ *  --output_dir                                                              TEXT                                 Directory for the output files [required]                                                                        │
│ *  --input_raw_data                                                          TEXT                                 Path to the input raw data [required]                                                                            │
│ *  --db_dir                                                                  TEXT                                 Directory for the database [required]                                                                            │
│    --methods                                                                 METHODS                              Specify the annotation methods to use (comma-separated). Options: diamond, hmm, dbCANsub. Example: --methods     │
│                                                                                                                   diamond,hmm or --methods hmm [default: diamond,hmm,dbCANsub]                                                     │
│    --threads                                                                 INTEGER                              Number of threads                                                                                                │
│    --verbose_option                                                                                               Enable verbose option for diamond                                                                                │
│    --e_value_threshold                                                       FLOAT                                E-value threshold for diamond                                                                                    │
│    --large_input_threshold_mb                                                INTEGER                              Auto-enable large mode when input fasta size exceeds this threshold (MB). [default: 5000]                        │
│    --large/--no-large                                                                                             Enable streaming-safe mode for very large inputs (reduces OOM risk). [default: no-large]                         │
│    --enable_memory_monitoring/--no-enable_memory_monitoring                                                       Enable memory monitoring and adaptive throttling for pyhmmer. [default: enable_memory_monitoring]                │
│    --max_retries                                                             INTEGER                              Maximum retries on OOM during pyhmmer search. [default: 3]                                                       │
│    --memory_safety_factor                                                    FLOAT                                Safety factor for auto batch size (0.0-1.0, smaller = safer). [default: 0.5]                                     │
│    --max_memory_usage                                                        FLOAT                                Maximum system memory usage ratio before warnings/throttling (0.0-1.0). [default: 0.8]                           │
│    --batch_size                                                              INTEGER                              Process this many sequences per batch in pyhmmer (None = auto).                                                  │
│    --csv_buffer_size                                                         INTEGER                              Flush this many HMM hits to disk at once (larger can be faster, uses a bit more RAM). [default: 5000]            │
│    --coverage_threshold_dbcan                                                FLOAT                                Coverage threshold for dbCAN HMMER                                                                               │
│    --e_value_threshold_dbcan                                                 FLOAT                                E-value threshold for dbCAN HMMER                                                                                │
│    --large_input_threshold_mb_dbsub                                          INTEGER                              (dbCAN-sub) Auto-enable large mode when input fasta exceeds this threshold (MB). [default: 5000]                 │
│    --large_dbsub/--no-large_dbsub                                                                                 (dbCAN-sub) Enable streaming-safe mode for very large inputs. [default: no-large_dbsub]                          │
│    --enable_memory_monitoring_dbsub/--no-enable_memory_monitoring_dbsub                                           (dbCAN-sub) Enable memory monitoring and adaptive throttling for pyhmmer. [default:                              │
│                                                                                                                   enable_memory_monitoring_dbsub]                                                                                  │
│    --max_retries_dbsub                                                       INTEGER                              (dbCAN-sub) Maximum retries on OOM during pyhmmer search. [default: 3]                                           │
│    --memory_safety_factor_dbsub                                              FLOAT                                (dbCAN-sub) Safety factor for auto batch size (0.0-1.0). [default: 0.5]                                          │
│    --max_memory_usage_dbsub                                                  FLOAT                                (dbCAN-sub) Maximum system memory usage ratio before warnings/throttling (0.0-1.0). [default: 0.8]               │
│    --batch_size_dbsub                                                        INTEGER                              (dbCAN-sub) Sequences per batch in pyhmmer (None = auto).                                                        │
│    --csv_buffer_size_dbsub                                                   INTEGER                              (dbCAN-sub) Flush this many HMM hits to disk at once. [default: 5000]                                            │
│    --coverage_threshold_dbsub                                                FLOAT                                Coverage threshold for dbCAN-sub HMMER                                                                           │
│    --e_value_threshold_dbsub                                                 FLOAT                                E-value threshold for dbCAN-sub HMMER                                                                            │
│    --coverage_threshold_stp                                                  FLOAT                                Coverage threshold for STP HMMER                                                                                 │
│    --e_value_threshold_stp                                                   FLOAT                                E-value threshold for STP HMMER                                                                                  │
│    --fungi/--no-fungi                                                                                             Enable fungi mode for TF HMMER                                                                                   │
│    --coverage_threshold_tf                                                   FLOAT                                Coverage threshold for TF HMMER                                                                                  │
│    --e_value_threshold_tf                                                    FLOAT                                E-value threshold for TF HMMER                                                                                   │
│    --prokaryotic/--no-prokaryotic                                                                                 Enable prokaryotic mode for TF                                                                                   │
│    --coverage_threshold_tf_diamond                                           FLOAT                                Coverage threshold for TF                                                                                        │
│    --e_value_threshold_tf_diamond                                            FLOAT                                E-value threshold for TF                                                                                         │
│    --coverage_threshold_tc                                                   FLOAT                                Coverage threshold for TC                                                                                        │
│    --e_value_threshold_tc                                                    FLOAT                                E-value threshold for TC                                                                                         │
│    --gff_type                                                                TEXT                                 GFF file type. Auto-set to prodigal when --mode != protein                                                       │
│    --input_gff                                                               TEXT                                 Input GFF file. When --mode != protein this is auto-set to <output_dir>/uniInput.gff                             │
│    --feature_type                                                            TEXT                                 GFF feature types to include (multiple allowed).                                                                 │
│    --min_cluster_genes                                                       INTEGER                              Minimum number of genes required per CGC.                                                                        │
│    --min_core_cazyme                                                         INTEGER                              Minimum number of core CAZymes required per CGC.                                                                 │
│    --extend_gene_count                                                       INTEGER                              When --extend_mode=gene, extend this many genes on each side.                                                    │
│    --extend_bp                                                               INTEGER                              When --extend_mode=bp, extend this many base pairs on each side.                                                 │
│    --extend_mode                                                             [none|bp|gene]                       Extend CGC region on both sides after identification. 'bp' extends by base pairs; 'gene' extends by gene count;  │
│                                                                                                                   'none' disables extension.                                                                                       │
│    --use_distance                                                                                                 Use base pair distance in CGC annotation.                                                                        │
│    --use_null_genes/--no-use_null_genes                                                                           Use null genes in CGC annotation.                                                                                │
│    --base_pair_distance                                                      INTEGER                              Base pair distance of signature genes.                                                                           │
│    --num_null_gene                                                           INTEGER                              Maximum number of null genes allowed between signature genes.                                                    │
│    --additional_min_categories                                               INTEGER                              When --additional_logic=any, require at least this number of distinct additional categories.                     │
│    --additional_logic                                                        [all|any]                            Logic for multiple --additional_genes: 'all' requires all present; 'any' requires at least one.                  │
│    --additional_genes                                                        TEXT                                 Specify additional gene types for CGC annotation, including TC, TF, and STP                                      │
│    --help                                                                                                         Show this message and exit.                                                                                      │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## dbcan_easy_substrate

### Tool Description
Perform complete CGC analysis: CAZyme annotation, GFF processing, CGC identification, and substrate prediction in one step.

### Metadata
- **Docker Image**: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
- **Homepage**: http://bcb.unl.edu/dbCAN2/
- **Package**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Total Downloads**: 25.8K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/linnabrown/run_dbcan
- **Stars**: N/A
### Original Help Text
```text
 Usage: run_dbcan easy_substrate [OPTIONS]

 Perform complete CGC analysis: CAZyme annotation, GFF processing, CGC identification, and substrate prediction in one step.

╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│    --verbose                                                             -v                                                Enable verbose logging (equivalent to --log-level DEBUG)                                                │
│    --log-file                                                                         PATH                                 Write logs to file in addition to console                                                               │
│    --log-level                                                                        [DEBUG|INFO|WARNING|ERROR|CRITICAL]  Set logging level (default: WARNING, only shows warnings and errors)                                    │
│    --substrate_scors                                                     -subs        INTEGER                              substrate score                                                                                         │
│    --num_of_protein_substrate_cutoff                                     -npsc        INTEGER                              num of protein substrate                                                                                │
│    --num_of_domains_substrate_cutoff                                     -ndsc        INTEGER                              num of domains substrate                                                                                │
│    --hmmevalue                                                           -hmmevalue   FLOAT                                HMM evalue                                                                                              │
│    --hmmcov                                                              -hmmcov      FLOAT                                hmm coverage                                                                                            │
│    --evalue_cutoff                                                       -evalue      FLOAT                                evalue                                                                                                  │
│    --bitscore_cutoff                                                     -bsc         FLOAT                                bit score                                                                                               │
│    --coverage_cutoff                                                     -cov         FLOAT                                coverage                                                                                                │
│    --identity_cutoff                                                     -iden        FLOAT                                identity                                                                                                │
│    --extra_pair_type_num                                                 -eptn        TEXT                                 extra pair number                                                                                       │
│    --extra_pair_type                                                     -ept         TEXT                                 extra pair type                                                                                         │
│    --total_pair_num                                                      -tpn         INTEGER                              total pair number                                                                                       │
│    --CAZyme_pair_num                                                     -cpn         INTEGER                              num of CAZyme                                                                                           │
│    --uniq_query_cgc_gene_num                                             -uqcgn       INTEGER                              num of uniq gene hit of cgc                                                                             │
│    --uniq_pul_gene_hit_num                                               -upghn       INTEGER                              num of uniq gene hit of pul                                                                             │
│ *  --db_dir                                                                           TEXT                                 database folder [required]                                                                              │
│    --odbcanpul                                                           -odbcanpul                                        export dbcan pul sub result                                                                             │
│    --odbcan_sub                                                          -odbcan_sub  TEXT                                 export dbcan-sub sub result                                                                             │
│    --env                                                                 -env         TEXT                                 run environment                                                                                         │
│    --rerun                                                               -rerun                                            re run the prediction                                                                                   │
│    --workdir                                                             -w           TEXT                                 work directory                                                                                          │
│    --out                                                                 -o           TEXT                                 substrate prediction result                                                                             │
│    --pul                                                                              TEXT                                 dbCAN-PUL PUL.faa                                                                                       │
│ *  --mode                                                                             TEXT                                 Mode of input sequence [required]                                                                       │
│ *  --output_dir                                                                       TEXT                                 Directory for the output files [required]                                                               │
│ *  --input_raw_data                                                                   TEXT                                 Path to the input raw data [required]                                                                   │
│    --methods                                                                          METHODS                              Specify the annotation methods to use (comma-separated). Options: diamond, hmm, dbCANsub. Example:      │
│                                                                                                                            --methods diamond,hmm or --methods hmm [default: diamond,hmm,dbCANsub]                                  │
│    --threads                                                                          INTEGER                              Number of threads                                                                                       │
│    --verbose_option                                                                                                        Enable verbose option for diamond                                                                       │
│    --e_value_threshold                                                                FLOAT                                E-value threshold for diamond                                                                           │
│    --large_input_threshold_mb                                                         INTEGER                              Auto-enable large mode when input fasta size exceeds this threshold (MB). [default: 5000]               │
│    --large/--no-large                                                                                                      Enable streaming-safe mode for very large inputs (reduces OOM risk). [default: no-large]                │
│    --enable_memory_monitoring/--no-enable_memory_monitoring                                                                Enable memory monitoring and adaptive throttling for pyhmmer. [default: enable_memory_monitoring]       │
│    --max_retries                                                                      INTEGER                              Maximum retries on OOM during pyhmmer search. [default: 3]                                              │
│    --memory_safety_factor                                                             FLOAT                                Safety factor for auto batch size (0.0-1.0, smaller = safer). [default: 0.5]                            │
│    --max_memory_usage                                                                 FLOAT                                Maximum system memory usage ratio before warnings/throttling (0.0-1.0). [default: 0.8]                  │
│    --batch_size                                                                       INTEGER                              Process this many sequences per batch in pyhmmer (None = auto).                                         │
│    --csv_buffer_size                                                                  INTEGER                              Flush this many HMM hits to disk at once (larger can be faster, uses a bit more RAM). [default: 5000]   │
│    --coverage_threshold_dbcan                                                         FLOAT                                Coverage threshold for dbCAN HMMER                                                                      │
│    --e_value_threshold_dbcan                                                          FLOAT                                E-value threshold for dbCAN HMMER                                                                       │
│    --large_input_threshold_mb_dbsub                                                   INTEGER                              (dbCAN-sub) Auto-enable large mode when input fasta exceeds this threshold (MB). [default: 5000]        │
│    --large_dbsub/--no-large_dbsub                                                                                          (dbCAN-sub) Enable streaming-safe mode for very large inputs. [default: no-large_dbsub]                 │
│    --enable_memory_monitoring_dbsub/--no-enable_memory_monitoring_dbsub                                                    (dbCAN-sub) Enable memory monitoring and adaptive throttling for pyhmmer. [default:                     │
│                                                                                                                            enable_memory_monitoring_dbsub]                                                                         │
│    --max_retries_dbsub                                                                INTEGER                              (dbCAN-sub) Maximum retries on OOM during pyhmmer search. [default: 3]                                  │
│    --memory_safety_factor_dbsub                                                       FLOAT                                (dbCAN-sub) Safety factor for auto batch size (0.0-1.0). [default: 0.5]                                 │
│    --max_memory_usage_dbsub                                                           FLOAT                                (dbCAN-sub) Maximum system memory usage ratio before warnings/throttling (0.0-1.0). [default: 0.8]      │
│    --batch_size_dbsub                                                                 INTEGER                              (dbCAN-sub) Sequences per batch in pyhmmer (None = auto).                                               │
│    --csv_buffer_size_dbsub                                                            INTEGER                              (dbCAN-sub) Flush this many HMM hits to disk at once. [default: 5000]                                   │
│    --coverage_threshold_dbsub                                                         FLOAT                                Coverage threshold for dbCAN-sub HMMER                                                                  │
│    --e_value_threshold_dbsub                                                          FLOAT                                E-value threshold for dbCAN-sub HMMER                                                                   │
│    --coverage_threshold_stp                                                           FLOAT                                Coverage threshold for STP HMMER                                                                        │
│    --e_value_threshold_stp                                                            FLOAT                                E-value threshold for STP HMMER                                                                         │
│    --fungi/--no-fungi                                                                                                      Enable fungi mode for TF HMMER                                                                          │
│    --coverage_threshold_tf                                                            FLOAT                                Coverage threshold for TF HMMER                                                                         │
│    --e_value_threshold_tf                                                             FLOAT                                E-value threshold for TF HMMER                                                                          │
│    --prokaryotic/--no-prokaryotic                                                                                          Enable prokaryotic mode for TF                                                                          │
│    --coverage_threshold_tf_diamond                                                    FLOAT                                Coverage threshold for TF                                                                               │
│    --e_value_threshold_tf_diamond                                                     FLOAT                                E-value threshold for TF                                                                                │
│    --coverage_threshold_tc                                                            FLOAT                                Coverage threshold for TC                                                                               │
│    --e_value_threshold_tc                                                             FLOAT                                E-value threshold for TC                                                                                │
│    --gff_type                                                                         TEXT                                 GFF file type. Auto-set to prodigal when --mode != protein                                              │
│    --input_gff                                                                        TEXT                                 Input GFF file. When --mode != protein this is auto-set to <output_dir>/uniInput.gff                    │
│    --feature_type                                                                     TEXT                                 GFF feature types to include (multiple allowed).                                                        │
│    --min_cluster_genes                                                                INTEGER                              Minimum number of genes required per CGC.                                                               │
│    --min_core_cazyme                                                                  INTEGER                              Minimum number of core CAZymes required per CGC.                                                        │
│    --extend_gene_count                                                                INTEGER                              When --extend_mode=gene, extend this many genes on each side.                                           │
│    --extend_bp                                                                        INTEGER                              When --extend_mode=bp, extend this many base pairs on each side.                                        │
│    --extend_mode                                                                      [none|bp|gene]                       Extend CGC region on both sides after identification. 'bp' extends by base pairs; 'gene' extends by     │
│                                                                                                                            gene count; 'none' disables extension.                                                                  │
│    --use_distance                                                                                                          Use base pair distance in CGC annotation.                                                               │
│    --use_null_genes/--no-use_null_genes                                                                                    Use null genes in CGC annotation.                                                                       │
│    --base_pair_distance                                                               INTEGER                              Base pair distance of signature genes.                                                                  │
│    --num_null_gene                                                                    INTEGER                              Maximum number of null genes allowed between signature genes.                                           │
│    --additional_min_categories                                                        INTEGER                              When --additional_logic=any, require at least this number of distinct additional categories.            │
│    --additional_logic                                                                 [all|any]                            Logic for multiple --additional_genes: 'all' requires all present; 'any' requires at least one.         │
│    --additional_genes                                                                 TEXT                                 Specify additional gene types for CGC annotation, including TC, TF, and STP                             │
│    --help                                                                                                                  Show this message and exit.                                                                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## dbcan_gff_process

### Tool Description
Generate GFF for CGC identification. need --input_gff when --input_raw_data is protein sequence. if --input_gff is not provided, will set default <output_dir>/uniInput.gff.

### Metadata
- **Docker Image**: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
- **Homepage**: http://bcb.unl.edu/dbCAN2/
- **Package**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Total Downloads**: 25.8K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/linnabrown/run_dbcan
- **Stars**: N/A
### Original Help Text
```text
 Usage: run_dbcan gff_process [OPTIONS]

 Generate GFF for CGC identification. need --input_gff when --input_raw_data is protein sequence. if --input_gff is not provided, will set default <output_dir>/uniInput.gff.

╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│    --verbose                        -v                                       Enable verbose logging (equivalent to --log-level DEBUG)                                                                                              │
│    --log-file                           PATH                                 Write logs to file in addition to console                                                                                                             │
│    --log-level                          [DEBUG|INFO|WARNING|ERROR|CRITICAL]  Set logging level (default: WARNING, only shows warnings and errors)                                                                                  │
│ *  --db_dir                             TEXT                                 Directory for the database [required]                                                                                                                 │
│ *  --output_dir                         TEXT                                 Directory for the output files [required]                                                                                                             │
│    --threads                            INTEGER                              Number of threads                                                                                                                                     │
│    --coverage_threshold_stp             FLOAT                                Coverage threshold for STP HMMER                                                                                                                      │
│    --e_value_threshold_stp              FLOAT                                E-value threshold for STP HMMER                                                                                                                       │
│    --fungi/--no-fungi                                                        Enable fungi mode for TF HMMER                                                                                                                        │
│    --coverage_threshold_tf              FLOAT                                Coverage threshold for TF HMMER                                                                                                                       │
│    --e_value_threshold_tf               FLOAT                                E-value threshold for TF HMMER                                                                                                                        │
│    --prokaryotic/--no-prokaryotic                                            Enable prokaryotic mode for TF                                                                                                                        │
│    --coverage_threshold_tf_diamond      FLOAT                                Coverage threshold for TF                                                                                                                             │
│    --e_value_threshold_tf_diamond       FLOAT                                E-value threshold for TF                                                                                                                              │
│    --coverage_threshold_tc              FLOAT                                Coverage threshold for TC                                                                                                                             │
│    --e_value_threshold_tc               FLOAT                                E-value threshold for TC                                                                                                                              │
│    --coverage_threshold_sulfatase       FLOAT                                Coverage threshold for Sulfatase                                                                                                                      │
│    --e_value_threshold_sulfatase        FLOAT                                E-value threshold for Sulfatase                                                                                                                       │
│    --coverage_threshold_peptidase       FLOAT                                Coverage threshold for Peptidase                                                                                                                      │
│    --e_value_threshold_peptidase        FLOAT                                E-value threshold for Peptidase                                                                                                                       │
│    --gff_type                           TEXT                                 GFF file type. Auto-set to prodigal when --mode != protein                                                                                            │
│    --input_gff                          TEXT                                 Input GFF file. When --mode != protein this is auto-set to <output_dir>/uniInput.gff                                                                  │
│    --help                                                                    Show this message and exit.                                                                                                                           │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## dbcan_substrate_prediction

### Tool Description
Predict the substrates of CAZyme gene clusters (CGCs) found by an earlier run_dbcan step, using dbCAN-PUL and dbCAN-sub.

### Metadata
- **Docker Image**: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
- **Homepage**: http://bcb.unl.edu/dbCAN2/
- **Package**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbcan/overview
- **Total Downloads**: 25.8K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/linnabrown/run_dbcan
- **Stars**: N/A
### Original Help Text
```text
 Usage: run_dbcan substrate_prediction [OPTIONS]

╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│    --verbose                          -v                                                Enable verbose logging (equivalent to --log-level DEBUG)                                                                                   │
│    --log-file                                      PATH                                 Write logs to file in addition to console                                                                                                  │
│    --log-level                                     [DEBUG|INFO|WARNING|ERROR|CRITICAL]  Set logging level (default: WARNING, only shows warnings and errors)                                                                       │
│ *  --db_dir                                        TEXT                                 database folder [required]                                                                                                                 │
│    --odbcanpul                        -odbcanpul                                        export dbcan pul sub result                                                                                                                │
│    --odbcan_sub                       -odbcan_sub  TEXT                                 export dbcan-sub sub result                                                                                                                │
│    --env                              -env         TEXT                                 run environment                                                                                                                            │
│    --rerun                            -rerun                                            re run the prediction                                                                                                                      │
│    --workdir                          -w           TEXT                                 work directory                                                                                                                             │
│    --out                              -o           TEXT                                 substrate prediction result                                                                                                                │
│    --pul                                           TEXT                                 dbCAN-PUL PUL.faa                                                                                                                          │
│ *  --mode                                          TEXT                                 Mode of input sequence [required]                                                                                                          │
│ *  --output_dir                                    TEXT                                 Directory for the output files [required]                                                                                                  │
│ *  --input_raw_data                                TEXT                                 Path to the input raw data [required]                                                                                                      │
│    --evalue_cutoff                    -evalue      FLOAT                                evalue                                                                                                                                     │
│    --bitscore_cutoff                  -bsc         FLOAT                                bit score                                                                                                                                  │
│    --coverage_cutoff                  -cov         FLOAT                                coverage                                                                                                                                   │
│    --identity_cutoff                  -iden        FLOAT                                identity                                                                                                                                   │
│    --extra_pair_type_num              -eptn        TEXT                                 extra pair number                                                                                                                          │
│    --extra_pair_type                  -ept         TEXT                                 extra pair type                                                                                                                            │
│    --total_pair_num                   -tpn         INTEGER                              total pair number                                                                                                                          │
│    --CAZyme_pair_num                  -cpn         INTEGER                              num of CAZyme                                                                                                                              │
│    --uniq_query_cgc_gene_num          -uqcgn       INTEGER                              num of uniq gene hit of cgc                                                                                                                │
│    --uniq_pul_gene_hit_num            -upghn       INTEGER                              num of uniq gene hit of pul                                                                                                                │
│    --substrate_scors                  -subs        INTEGER                              substrate score                                                                                                                            │
│    --num_of_protein_substrate_cutoff  -npsc        INTEGER                              num of protein substrate                                                                                                                   │
│    --num_of_domains_substrate_cutoff  -ndsc        INTEGER                              num of domains substrate                                                                                                                   │
│    --hmmevalue                        -hmmevalue   FLOAT                                HMM evalue                                                                                                                                 │
│    --hmmcov                           -hmmcov      FLOAT                                hmm coverage                                                                                                                               │
│    --help                                                                               Show this message and exit.                                                                                                                │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

