# mykatlas CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mykatlas_diff | Failed | tool bug: diff crashes with TypeError write() argument must be str, not bytes (Python 3 port error) |
| mykatlas_genotype | PASS | ran on 500k real M. tuberculosis reads and the Bradley TB probe set; reference alleles at depth about 34, no resistance variants (susceptible, same as mykrobe) |
| mykatlas_place | Failed | image problem: ModuleNotFoundError mykatlas.treeplacing |
| mykatlas_walk | Failed | tool bug: walk crashes with TypeError 'dict_values' object is not subscriptable (Python 3 port error) |

## mykatlas_genotype

### Tool Description
Genotype a sample using a probe set

### Metadata
- **Docker Image**: quay.io/biocontainers/mykatlas:0.6.1--py39h6a678da_6
- **Homepage**: http://github.com/phelimb/atlas
- **Package**: https://anaconda.org/channels/bioconda/packages/mykatlas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: atlas genotype [-h] [-k kmer] [--tmp TMP] [--keep_tmp]
                      [--skeleton_dir SKELETON_DIR]
                      [--mccortex31_path MCCORTEX31_PATH] [-t THREADS]
                      [-m MEMORY] [--expected_depth EXPECTED_DEPTH]
                      [-1 seq [seq ...]] [-c ctx] [-f] [--ont]
                      [--ignore_filtered IGNORE_FILTERED] [--model model]
                      [--filters FILTERS [FILTERS ...]] [--report_all_calls]
                      [--expected_error_rate EXPECTED_ERROR_RATE]
                      [--min_variant_conf MIN_VARIANT_CONF]
                      [--min_gene_conf MIN_GENE_CONF]
                      [--min_gene_percent_covg_threshold MIN_GENE_PERCENT_COVG_THRESHOLD]
                      [-q]
                      sample probe_set

positional arguments:
  sample                sample id
  probe_set             probe_set

optional arguments:
  -h, --help            show this help message and exit
  -k kmer, --kmer kmer  kmer length (default:21)
  --tmp TMP             tmp directory (default: /tmp/)
  --keep_tmp            Dont remove tmp files
  --skeleton_dir SKELETON_DIR
                        directory for skeleton binaries
  --mccortex31_path MCCORTEX31_PATH
                        Path to mccortex31. Default mccortex31
  -t THREADS, --threads THREADS
                        threads
  -m MEMORY, --memory MEMORY
                        memory for graph constuction
  --expected_depth EXPECTED_DEPTH
                        expected depth
  -1 seq [seq ...], --seq seq [seq ...]
                        sequence files (fasta,fastq,bam)
  -c ctx, --ctx ctx     cortex graph binary
  -f, --force           force
  --ont                 Set default for ONT data
  --ignore_filtered IGNORE_FILTERED
                        don't include filtered genotypes
  --model model         species
  --filters FILTERS [FILTERS ...]
                        don't include filtered genotypes
  --report_all_calls    report all calls
  --expected_error_rate EXPECTED_ERROR_RATE
                        Expected sequencing error rate. Set to 0.15 for ONT
                        genotyping.
  --min_variant_conf MIN_VARIANT_CONF
                        minimum genotype confidence for variant genotyping
  --min_gene_conf MIN_GENE_CONF
                        minimum genotype confidence for gene genotyping
  --min_gene_percent_covg_threshold MIN_GENE_PERCENT_COVG_THRESHOLD
                        all genes alleles found above this percent coverage
                        will be reported (default 100 (only best alleles
                        reported))
  -q, --quiet           do not output warnings to stderr
```

## mykatlas_walk

### Tool Description
Walk through a graph using an existing sequence probe set as seeds. default walking algorithm is a depth first search

### Metadata
- **Docker Image**: quay.io/biocontainers/mykatlas:0.6.1--py39h6a678da_6
- **Homepage**: http://github.com/phelimb/atlas
- **Package**: https://anaconda.org/channels/bioconda/packages/mykatlas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: atlas walk [-h] [-k kmer] [--tmp TMP] [--keep_tmp]
                  [--skeleton_dir SKELETON_DIR]
                  [--mccortex31_path MCCORTEX31_PATH] [-t THREADS] [-m MEMORY]
                  [--expected_depth EXPECTED_DEPTH] [-1 seq [seq ...]]
                  [-c ctx] [-f] [--ont] [--ignore_filtered IGNORE_FILTERED]
                  [--model model] [--filters FILTERS [FILTERS ...]]
                  [--report_all_calls]
                  [--expected_error_rate EXPECTED_ERROR_RATE]
                  [--min_variant_conf MIN_VARIANT_CONF]
                  [--min_gene_conf MIN_GENE_CONF]
                  [--min_gene_percent_covg_threshold MIN_GENE_PERCENT_COVG_THRESHOLD]
                  [-q] [--also-genotype] [--show-all-paths]
                  sample probe_set

positional arguments:
  sample                sample id
  probe_set             probe_set

optional arguments:
  -h, --help            show this help message and exit
  -k kmer, --kmer kmer  kmer length (default:21)
  --tmp TMP             tmp directory (default: /tmp/)
  --keep_tmp            Dont remove tmp files
  --skeleton_dir SKELETON_DIR
                        directory for skeleton binaries
  --mccortex31_path MCCORTEX31_PATH
                        Path to mccortex31. Default mccortex31
  -t THREADS, --threads THREADS
                        threads
  -m MEMORY, --memory MEMORY
                        memory for graph constuction
  --expected_depth EXPECTED_DEPTH
                        expected depth
  -1 seq [seq ...], --seq seq [seq ...]
                        sequence files (fasta,fastq,bam)
  -c ctx, --ctx ctx     cortex graph binary
  -f, --force           force
  --ont                 Set default for ONT data
  --ignore_filtered IGNORE_FILTERED
                        don't include filtered genotypes
  --model model         species
  --filters FILTERS [FILTERS ...]
                        don't include filtered genotypes
  --report_all_calls    report all calls
  --expected_error_rate EXPECTED_ERROR_RATE
                        Expected sequencing error rate. Set to 0.15 for ONT
                        genotyping.
  --min_variant_conf MIN_VARIANT_CONF
                        minimum genotype confidence for variant genotyping
  --min_gene_conf MIN_GENE_CONF
                        minimum genotype confidence for gene genotyping
  --min_gene_percent_covg_threshold MIN_GENE_PERCENT_COVG_THRESHOLD
                        all genes alleles found above this percent coverage
                        will be reported (default 100 (only best alleles
                        reported))
  -q, --quiet           do not output warnings to stderr
  --also-genotype
  --show-all-paths
```

## mykatlas_diff

### Tool Description
Outputs novel sequence by calculating the difference between the sequence and combined graph

### Metadata
- **Docker Image**: quay.io/biocontainers/mykatlas:0.6.1--py39h6a678da_6
- **Homepage**: http://github.com/phelimb/atlas
- **Package**: https://anaconda.org/channels/bioconda/packages/mykatlas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: atlas diff [-h] [-k kmer] [--tmp TMP] [--keep_tmp]
                  [--skeleton_dir SKELETON_DIR]
                  [--mccortex31_path MCCORTEX31_PATH] [-t THREADS] [-m MEMORY]
                  [--expected_depth EXPECTED_DEPTH] [-1 seq [seq ...]]
                  [-c ctx] [-q] [--add]
                  sample graph

positional arguments:
  sample                sample id
  graph                 The graph to compare new sample against

optional arguments:
  -h, --help            show this help message and exit
  -k kmer, --kmer kmer  kmer length (default:21)
  --tmp TMP             tmp directory (default: /tmp/)
  --keep_tmp            Dont remove tmp files
  --skeleton_dir SKELETON_DIR
                        directory for skeleton binaries
  --mccortex31_path MCCORTEX31_PATH
                        Path to mccortex31. Default mccortex31
  -t THREADS, --threads THREADS
                        threads
  -m MEMORY, --memory MEMORY
                        memory for graph constuction
  --expected_depth EXPECTED_DEPTH
                        expected depth
  -1 seq [seq ...], --seq seq [seq ...]
                        sequence files (fasta,fastq,bam)
  -c ctx, --ctx ctx     cortex graph binary
  -q, --quiet           do not output warnings to stderr
  --add                 after comparing, add the new sample to the graph
```

## mykatlas_place

### Tool Description
Place a sample on a prebuilt tree

### Metadata
- **Docker Image**: quay.io/biocontainers/mykatlas:0.6.1--py39h6a678da_6
- **Homepage**: http://github.com/phelimb/atlas
- **Package**: https://anaconda.org/channels/bioconda/packages/mykatlas/overview
- **Validation**: PASS

### Original Help Text
```text
usage: atlas place [-h] [--db_name db_name] [-f] [-q] [--tree tree]
                   [--searchable_samples searchable_samples] [--no-cache]
                   sample

positional arguments:
  sample                sample id

optional arguments:
  -h, --help            show this help message and exit
  --db_name db_name     db_name
  -f, --force           force
  -q, --quiet           do not output warnings to stderr
  --tree tree           tree
  --searchable_samples searchable_samples
                        list of samples (file)
  --no-cache
```

