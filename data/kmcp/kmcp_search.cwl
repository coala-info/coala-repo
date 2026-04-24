cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmcp search
label: kmcp_search
doc: "Search sequences against a database\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: read1_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Single-end read files.
    inputBinding:
      position: 1
  - id: read2_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Single-end read files.
    inputBinding:
      position: 2
  - id: unpaired_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Unpaired read files.
    inputBinding:
      position: 3
  - id: database_dir
    type: Directory
    doc: Database directory created by "kmcp index". Please add 
      -w/--load-whole-db for databases on network-attached storages (NAS), e.g.,
      a computer cluster environment.
    inputBinding:
      position: 104
      prefix: --db-dir
  - id: default_name_map
    type:
      - 'null'
      - boolean
    doc: Load ${db}/__name_mapping.tsv for mapping name first.
    inputBinding:
      position: 104
      prefix: --default-name-map
  - id: do_not_sort
    type:
      - 'null'
      - boolean
    doc: Do not sort matches of a query.
    inputBinding:
      position: 104
      prefix: --do-not-sort
  - id: infile_list
    type:
      - 'null'
      - File
    doc: File of input files list (one file per line). If given, they are 
      appended to files from CLI arguments.
    inputBinding:
      position: 104
      prefix: --infile-list
  - id: keep_top_scores
    type:
      - 'null'
      - int
    doc: Keep matches with the top N scores for a query, 0 for all.
    inputBinding:
      position: 104
      prefix: --keep-top-scores
  - id: keep_unmatched
    type:
      - 'null'
      - boolean
    doc: Keep unmatched query sequence information.
    inputBinding:
      position: 104
      prefix: --keep-unmatched
  - id: kmer_dedup_threshold
    type:
      - 'null'
      - int
    doc: Remove duplicated kmers for a query with >= X k-mers.
    inputBinding:
      position: 104
      prefix: --kmer-dedup-threshold
  - id: load_whole_db
    type:
      - 'null'
      - boolean
    doc: Load all index files into memory, it's faster for small databases but 
      needs more memory. Use this for databases on network-attached storages 
      (NAS). Please read "Index files loading modes" in "kmcp search -h".
    inputBinding:
      position: 104
      prefix: --load-whole-db
  - id: log
    type:
      - 'null'
      - File
    doc: Log file.
    inputBinding:
      position: 104
      prefix: --log
  - id: low_mem
    type:
      - 'null'
      - boolean
    doc: Do not load all index files into memory nor use mmap, the searching 
      would be very very slow for a large number of queries. Please read "Index 
      files loading modes" in "kmcp search -h".
    inputBinding:
      position: 104
      prefix: --low-mem
  - id: max_fpr
    type:
      - 'null'
      - float
    doc: Maximum false positive rate of a query.
    inputBinding:
      position: 104
      prefix: --max-fpr
  - id: min_kmers
    type:
      - 'null'
      - int
    doc: Minimum number of matched k-mers (sketches).
    inputBinding:
      position: 104
      prefix: --min-kmers
  - id: min_query_cov
    type:
      - 'null'
      - float
    doc: Minimum query coverage, i.e., proportion of matched k-mers and unique 
      k-mers of a query.
    inputBinding:
      position: 104
      prefix: --min-query-cov
  - id: min_query_len
    type:
      - 'null'
      - int
    doc: Minimum query length.
    inputBinding:
      position: 104
      prefix: --min-query-len
  - id: min_target_cov
    type:
      - 'null'
      - float
    doc: Minimum target coverage, i.e., proportion of matched k-mers and unique 
      k-mers of a target.
    inputBinding:
      position: 104
      prefix: --min-target-cov
  - id: name_maps
    type:
      - 'null'
      - type: array
        items: string
    doc: Tabular two-column file(s) mapping reference IDs to user-defined 
      values. Don't use this if you will use the result for metagenomic 
      profiling which needs the original reference IDs.
    inputBinding:
      position: 104
      prefix: --name-map
  - id: no_header_row
    type:
      - 'null'
      - boolean
    doc: Do not print header row.
    inputBinding:
      position: 104
      prefix: --no-header-row
  - id: query_id
    type:
      - 'null'
      - string
    doc: Custom query Id when using the whole file as a query.
    inputBinding:
      position: 104
      prefix: --query-id
  - id: query_whole_file
    type:
      - 'null'
      - boolean
    doc: Use the whole file as a query, e.g., for genome similarity estimation 
      against k-mer sketch database.
    inputBinding:
      position: 104
      prefix: --query-whole-file
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print any verbose information. But you can write them to file 
      with --log.
    inputBinding:
      position: 104
      prefix: --quiet
  - id: read1
    type:
      - 'null'
      - File
    doc: (Gzipped) read1 file.
    inputBinding:
      position: 104
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: (Gzipped) read2 file.
    inputBinding:
      position: 104
      prefix: --read2
  - id: sort_by
    type:
      - 'null'
      - string
    doc: Sort hits by "qcov", "tcov" or "jacc" (Jaccard Index).
    inputBinding:
      position: 104
      prefix: --sort-by
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs cores to use.
    inputBinding:
      position: 104
      prefix: --threads
  - id: try_se
    type:
      - 'null'
      - boolean
    doc: If paired-end reads have no hits, re-search with read1, if still fails,
      try read2.
    inputBinding:
      position: 104
      prefix: --try-se
  - id: use_filename
    type:
      - 'null'
      - boolean
    doc: Use file name as query ID when using the whole file as a query.
    inputBinding:
      position: 104
      prefix: --use-filename
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Out file, supports and recommends a ".gz" suffix ("-" for stdout).
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1
