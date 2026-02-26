# impg CWL Generation Report

## impg_index

### Tool Description
Create an IMPG index

### Metadata
- **Docker Image**: quay.io/biocontainers/impg:0.3.3--hdb3fbb7_0
- **Homepage**: https://github.com/pangenome/impg
- **Package**: https://anaconda.org/channels/bioconda/packages/impg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/impg/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2025-11-01
- **GitHub**: https://github.com/pangenome/impg
- **Stars**: N/A
### Original Help Text
```text
Create an IMPG index

Usage: impg index [OPTIONS]

Options:
  -h, --help  Print help

PAF input:
  -p, --paf-files <PAF_FILES>...  Path to the PAF files
      --paf-list <PAF_LIST>       Path to a text file containing paths to PAF files (one per line)

Index options:
  -i, --index <INDEX>  Path to the IMPG index file
  -f, --force-reindex  Force the regeneration of the index, even if it already exists

General options:
  -t, --threads <THREADS>  Number of threads for parallel processing [default: 4]
  -v, --verbose <VERBOSE>  Verbosity level (0 = error, 1 = info, 2 = debug) [default: 0]
```


## impg_lace

### Tool Description
Lace files together (graphs or VCFs)

### Metadata
- **Docker Image**: quay.io/biocontainers/impg:0.3.3--hdb3fbb7_0
- **Homepage**: https://github.com/pangenome/impg
- **Package**: https://anaconda.org/channels/bioconda/packages/impg/overview
- **Validation**: PASS

### Original Help Text
```text
Lace files together (graphs or VCFs)

Usage: impg lace [OPTIONS] --output <OUTPUT>

Options:
  -f, --files <FILES>...       List of input files (space-separated)
  -l, --file-list <FILE_LIST>  Text file containing input file paths (one per line)
      --format <FORMAT>        Input file format (gfa, vcf, auto) [default: auto]
  -o, --output <OUTPUT>        Output file path
      --compress <COMPRESS>    Output compression format (none, gzip, bgzip, zstd, auto) [default: auto]
      --fill-gaps <FILL_GAPS>  Gap filling mode: 0=none, 1=middle gaps only, 2=all gaps (requires --sequence-files or --sequence-list for end gaps, GFA mode only) [default: 0]
      --skip-validation        Skip path range length validation (faster but may miss data integrity issues)
  -h, --help                   Print help

Sequence input:
      --sequence-files <SEQUENCE_FILES>...
          List of sequence file paths (FASTA or AGC) (required for 'gfa', 'maf', and 'fasta')
      --sequence-list <SEQUENCE_LIST>
          Path to a text file containing paths to sequence files (FASTA or AGC) (required for 'gfa', 'maf', and 'fasta')
      --temp-dir <TEMP_DIR>
          Directory for temporary files
      --reference <REFERENCE>
          Reference (FASTA or AGC) file for validating contig lengths in VCF files

General options:
  -t, --threads <THREADS>  Number of threads for parallel processing [default: 4]
  -v, --verbose <VERBOSE>  Verbosity level (0 = error, 1 = info, 2 = debug) [default: 0]
```


## impg_partition

### Tool Description
Partition the alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/impg:0.3.3--hdb3fbb7_0
- **Homepage**: https://github.com/pangenome/impg
- **Package**: https://anaconda.org/channels/bioconda/packages/impg/overview
- **Validation**: PASS

### Original Help Text
```text
Partition the alignment

Usage: impg partition [OPTIONS] --window-size <WINDOW_SIZE>

Options:
  -h, --help  Print help

PAF input:
  -p, --paf-files <PAF_FILES>...  Path to the PAF files
      --paf-list <PAF_LIST>       Path to a text file containing paths to PAF files (one per line)

Index options:
  -i, --index <INDEX>  Path to the IMPG index file
  -f, --force-reindex  Force the regeneration of the index, even if it already exists

Partition options:
  -w, --window-size <WINDOW_SIZE>
          Window size for partitioning
      --starting-sequences-file <STARTING_SEQUENCES_FILE>
          Path to the file with sequence names to start with (one per line)
      --selection-mode <SELECTION_MODE>
          Selection mode for next sequence:
          - "longest": sequence with longest single missing region
          - "total": sequence with highest total missing regions
          - "sample[,separator]": sample with highest total missing regions
          - "haplotype[,separator]": haplotype highest total missing regions
          The sample/haplotype modes assume PanSN naming; '#' is the default separator. [default: longest]
      --min-missing-size <MIN_MISSING_SIZE>
          Minimum region size for missing regions [default: 3000]
      --min-boundary-distance <MIN_BOUNDARY_DISTANCE>
          Minimum distance from sequence start/end - closer regions will be extended to the boundaries [default: 3000]
      --separate-files
          Output separate files for each partition when 'bed'

Output options:
  -o, --output-format <OUTPUT_FORMAT>  Output format: 'bed', 'gfa' (v1.0), 'maf', or 'fasta' ('gfa', 'maf', and 'fasta' require --sequence-files or --sequence-list) [default: bed]
      --output-folder <OUTPUT_FOLDER>  Output folder for partition files (default: current directory)
      --reverse-complement             Reverse complement reverse strand sequences (for 'fasta' output)
      --force-large-region             Force processing of large regions (>10kbp) with maf/gfa output formats

Sequence input:
      --sequence-files <SEQUENCE_FILES>...
          List of sequence file paths (FASTA or AGC) (required for 'gfa', 'maf', and 'fasta')
      --sequence-list <SEQUENCE_LIST>
          Path to a text file containing paths to sequence files (FASTA or AGC) (required for 'gfa', 'maf', and 'fasta')

Alignment options:
      --poa-scoring <POA_SCORING>  POA alignment scores as match,mismatch,gap_open1,gap_extend1,gap_open2,gap_extend2 (for 'gfa' and 'maf') [default: 1,4,6,2,26,1]

Filtering and merging:
  -d, --merge-distance <MERGE_DISTANCE>  Maximum distance between regions to merge [default: 100000]
      --min-identity <MIN_IDENTITY>      Minimum gap-compressed identity threshold (0.0-1.0)

Transitive query options:
      --transitive-dfs
          Enable transitive queries with Depth-First Search (slower, but returns fewer overlapping results)
  -m, --max-depth <MAX_DEPTH>
          Maximum recursion depth for transitive overlaps (0 for no limit) [default: 2]
  -l, --min-transitive-len <MIN_TRANSITIVE_LEN>
          Minimum region size to consider for transitive queries [default: 10]
      --min-distance-between-ranges <MIN_DISTANCE_BETWEEN_RANGES>
          Minimum distance between transitive ranges to consider on the same sequence [default: 10]

General options:
  -t, --threads <THREADS>  Number of threads for parallel processing [default: 4]
  -v, --verbose <VERBOSE>  Verbosity level (0 = error, 1 = info, 2 = debug) [default: 0]
```


## impg_query

### Tool Description
Query overlaps in the alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/impg:0.3.3--hdb3fbb7_0
- **Homepage**: https://github.com/pangenome/impg
- **Package**: https://anaconda.org/channels/bioconda/packages/impg/overview
- **Validation**: PASS

### Original Help Text
```text
Query overlaps in the alignment

Usage: impg query [OPTIONS]

Options:
  -O, --output-basename <OUTPUT_BASENAME>  Destination file basename, or nothing for standard output
  -h, --help                               Print help

PAF input:
  -p, --paf-files <PAF_FILES>...  Path to the PAF files
      --paf-list <PAF_LIST>       Path to a text file containing paths to PAF files (one per line)

Index options:
  -i, --index <INDEX>  Path to the IMPG index file
  -f, --force-reindex  Force the regeneration of the index, even if it already exists

Query region:
  -r, --target-range <TARGET_RANGE>  Target range in the format `seq_name:start-end`
  -b, --target-bed <TARGET_BED>      Path to the BED file containing target regions

Filtering and merging:
  -d, --merge-distance <MERGE_DISTANCE>
          Maximum distance between regions to merge [default: 0]
      --no-merge
          Disable merging for all output formats
      --min-identity <MIN_IDENTITY>
          Minimum gap-compressed identity threshold (0.0-1.0)
      --subset-sequence-list <SUBSET_SEQUENCE_LIST>
          Path to a file listing sequence names to include (one per line)

Transitive queries:
  -x, --transitive  Enable transitive queries (with Breadth-First Search)

Transitive query options:
      --transitive-dfs
          Enable transitive queries with Depth-First Search (slower, but returns fewer overlapping results)
  -m, --max-depth <MAX_DEPTH>
          Maximum recursion depth for transitive overlaps (0 for no limit) [default: 2]
  -l, --min-transitive-len <MIN_TRANSITIVE_LEN>
          Minimum region size to consider for transitive queries [default: 10]
      --min-distance-between-ranges <MIN_DISTANCE_BETWEEN_RANGES>
          Minimum distance between transitive ranges to consider on the same sequence [default: 10]

Coordinate options:
      --original-sequence-coordinates  Update coordinates to original sequences when input sequences are subsequences (seq_name:start-end) for 'bed', 'bedpe', and 'paf'

Output options:
  -o, --output-format <OUTPUT_FORMAT>  Output format: 'auto' ('bed' for -r, 'bedpe' for -b), 'bed', 'bedpe', 'paf', 'gfa' (v1.0), 'maf', 'fasta', or 'fasta+paf' ('gfa', 'maf', 'fasta', and 'fasta+paf' require --sequence-files or --sequence-list) [default: auto]
      --reverse-complement             Reverse complement reverse strand sequences (for 'fasta' output)
      --force-large-region             Force processing of large regions (>10kbp) with maf/gfa output formats

Sequence input:
      --sequence-files <SEQUENCE_FILES>...
          List of sequence file paths (FASTA or AGC) (required for 'gfa', 'maf', and 'fasta')
      --sequence-list <SEQUENCE_LIST>
          Path to a text file containing paths to sequence files (FASTA or AGC) (required for 'gfa', 'maf', and 'fasta')

Alignment options:
      --poa-scoring <POA_SCORING>  POA alignment scores as match,mismatch,gap_open1,gap_extend1,gap_open2,gap_extend2 (for 'gfa' and 'maf') [default: 1,4,6,2,26,1]

General options:
  -t, --threads <THREADS>  Number of threads for parallel processing [default: 4]
  -v, --verbose <VERBOSE>  Verbosity level (0 = error, 1 = info, 2 = debug) [default: 0]
```


## impg_refine

### Tool Description
Refine loci to maximize the number of samples that span both ends of the region

### Metadata
- **Docker Image**: quay.io/biocontainers/impg:0.3.3--hdb3fbb7_0
- **Homepage**: https://github.com/pangenome/impg
- **Package**: https://anaconda.org/channels/bioconda/packages/impg/overview
- **Validation**: PASS

### Original Help Text
```text
Refine loci to maximize the number of samples that span both ends of the region

Usage: impg refine [OPTIONS]

Options:
  -h, --help  Print help

PAF input:
  -p, --paf-files <PAF_FILES>...  Path to the PAF files
      --paf-list <PAF_LIST>       Path to a text file containing paths to PAF files (one per line)

Index options:
  -i, --index <INDEX>  Path to the IMPG index file
  -f, --force-reindex  Force the regeneration of the index, even if it already exists

Query region:
  -r, --target-range <TARGET_RANGE>  Target range in the format `seq_name:start-end`
  -b, --target-bed <TARGET_BED>      Path to the BED file containing target regions

Filtering and merging:
  -d, --merge-distance <MERGE_DISTANCE>
          Maximum distance between regions to merge [default: 0]
      --no-merge
          Disable merging for all output formats
      --min-identity <MIN_IDENTITY>
          Minimum gap-compressed identity threshold (0.0-1.0)
      --subset-sequence-list <SUBSET_SEQUENCE_LIST>
          Path to a file listing sequence names to include (one per line)

Transitive queries:
  -x, --transitive  Enable transitive queries (with Breadth-First Search)

Transitive query options:
      --transitive-dfs
          Enable transitive queries with Depth-First Search (slower, but returns fewer overlapping results)
  -m, --max-depth <MAX_DEPTH>
          Maximum recursion depth for transitive overlaps (0 for no limit) [default: 2]
  -l, --min-transitive-len <MIN_TRANSITIVE_LEN>
          Minimum region size to consider for transitive queries [default: 10]
      --min-distance-between-ranges <MIN_DISTANCE_BETWEEN_RANGES>
          Minimum distance between transitive ranges to consider on the same sequence [default: 10]

Coordinate options:
      --original-sequence-coordinates  Update coordinates to original sequences when input sequences are subsequences (seq_name:start-end) for 'bed', 'bedpe', and 'paf'

Refinement options:
      --span-bp <SPAN_BP>
          Minimum number of bases that supporting samples must span at each region boundary [default: 1000]
      --max-extension <MAX_EXTENSION>
          Maximum per-side extension explored when maximizing boundary support. Values <= 1 are treated as fractions of the locus length; values > 1 as absolute bp [default: 0.5]
      --pansn-mode <PANSN_MODE>
          PanSN aggregation mode when counting support (sample/haplotype) [possible values: sample, haplotype]
      --extension-step <EXTENSION_STEP>
          Step size for expanding flanks (bp) [default: 1000]

Output options:
      --support-output <SUPPORT_OUTPUT>
          Optional BED file capturing the entities that span the refined region

General options:
  -t, --threads <THREADS>  Number of threads for parallel processing [default: 4]
  -v, --verbose <VERBOSE>  Verbosity level (0 = error, 1 = info, 2 = debug) [default: 0]
```


## impg_similarity

### Tool Description
Compute pairwise similarity between sequences in a region

### Metadata
- **Docker Image**: quay.io/biocontainers/impg:0.3.3--hdb3fbb7_0
- **Homepage**: https://github.com/pangenome/impg
- **Package**: https://anaconda.org/channels/bioconda/packages/impg/overview
- **Validation**: PASS

### Original Help Text
```text
Compute pairwise similarity between sequences in a region

Usage: impg similarity [OPTIONS]

Options:
  -h, --help  Print help

PAF input:
  -p, --paf-files <PAF_FILES>...  Path to the PAF files
      --paf-list <PAF_LIST>       Path to a text file containing paths to PAF files (one per line)

Index options:
  -i, --index <INDEX>  Path to the IMPG index file
  -f, --force-reindex  Force the regeneration of the index, even if it already exists

Query region:
  -r, --target-range <TARGET_RANGE>  Target range in the format `seq_name:start-end`
  -b, --target-bed <TARGET_BED>      Path to the BED file containing target regions

Filtering and merging:
  -d, --merge-distance <MERGE_DISTANCE>
          Maximum distance between regions to merge [default: 0]
      --no-merge
          Disable merging for all output formats
      --min-identity <MIN_IDENTITY>
          Minimum gap-compressed identity threshold (0.0-1.0)
      --subset-sequence-list <SUBSET_SEQUENCE_LIST>
          Path to a file listing sequence names to include (one per line)

Transitive queries:
  -x, --transitive  Enable transitive queries (with Breadth-First Search)

Transitive query options:
      --transitive-dfs
          Enable transitive queries with Depth-First Search (slower, but returns fewer overlapping results)
  -m, --max-depth <MAX_DEPTH>
          Maximum recursion depth for transitive overlaps (0 for no limit) [default: 2]
  -l, --min-transitive-len <MIN_TRANSITIVE_LEN>
          Minimum region size to consider for transitive queries [default: 10]
      --min-distance-between-ranges <MIN_DISTANCE_BETWEEN_RANGES>
          Minimum distance between transitive ranges to consider on the same sequence [default: 10]

Coordinate options:
      --original-sequence-coordinates  Update coordinates to original sequences when input sequences are subsequences (seq_name:start-end) for 'bed', 'bedpe', and 'paf'

Sequence input:
      --sequence-files <SEQUENCE_FILES>...
          List of sequence file paths (FASTA or AGC) (required for 'gfa', 'maf', and 'fasta')
      --sequence-list <SEQUENCE_LIST>
          Path to a text file containing paths to sequence files (FASTA or AGC) (required for 'gfa', 'maf', and 'fasta')

Alignment options:
      --poa-scoring <POA_SCORING>  POA alignment scores as match,mismatch,gap_open1,gap_extend1,gap_open2,gap_extend2 (for 'gfa' and 'maf') [default: 1,4,6,2,26,1]

Output options:
      --reverse-complement     Reverse complement reverse strand sequences (for 'fasta' output)
      --force-large-region     Force processing of large regions (>10kbp) with maf/gfa output formats
      --progress-bar           Show the progress bar
      --distances              Output distances instead of similarities
  -a, --all                    Emit entries for all pairs of groups, including those with zero intersection
      --delim <DELIM>          The part of each path name before this delimiter is a group identifier
      --delim-pos <DELIM_POS>  Consider the N-th occurrence of the delimiter (1-indexed, default: 1) [default: 1]

PCA options:
      --pca
          Perform PCA/MDS dimensionality reduction on the distance matrix
      --pca-components <PCA_COMPONENTS>
          Number of PCA components to output (default: 2) [default: 2]
      --polarize-n-prev <POLARIZE_N_PREV>
          Number of previous regions to use for adaptive polarization (0 to disable) [default: 3]
      --polarize-guide-samples <POLARIZE_GUIDE_SAMPLES>
          Comma-separated names of the samples to use for adaptive polarization
      --pca-measure <PCA_MEASURE>
          Similarity measure to use for PCA distance matrix ("jaccard", "cosine", or "dice") [default: jaccard]

General options:
  -t, --threads <THREADS>  Number of threads for parallel processing [default: 4]
  -v, --verbose <VERBOSE>  Verbosity level (0 = error, 1 = info, 2 = debug) [default: 0]
```


## impg_stats

### Tool Description
Print alignment statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/impg:0.3.3--hdb3fbb7_0
- **Homepage**: https://github.com/pangenome/impg
- **Package**: https://anaconda.org/channels/bioconda/packages/impg/overview
- **Validation**: PASS

### Original Help Text
```text
Print alignment statistics

Usage: impg stats [OPTIONS]

Options:
  -h, --help  Print help

PAF input:
  -p, --paf-files <PAF_FILES>...  Path to the PAF files
      --paf-list <PAF_LIST>       Path to a text file containing paths to PAF files (one per line)

Index options:
  -i, --index <INDEX>  Path to the IMPG index file
  -f, --force-reindex  Force the regeneration of the index, even if it already exists

General options:
  -t, --threads <THREADS>  Number of threads for parallel processing [default: 4]
  -v, --verbose <VERBOSE>  Verbosity level (0 = error, 1 = info, 2 = debug) [default: 0]
```

