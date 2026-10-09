cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmcp
  - search
label: kmcp_search
doc: "Search sequences against a database\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs:
  - id: db_dir
    type: Directory
    doc: "Database directory created by \"kmcp index\""
    inputBinding:
      position: 1
      prefix: "--db-dir"
  - id: default_name_map
    type: ['null', boolean]
    doc: "Load ${db}/__name_mapping.tsv for mapping name first"
    inputBinding:
      position: 1
      prefix: "--default-name-map"
  - id: do_not_sort
    type: ['null', boolean]
    doc: "Do not sort matches of a query"
    inputBinding:
      position: 1
      prefix: "--do-not-sort"
  - id: keep_top_scores
    type: ['null', int]
    doc: "Keep matches with the top N scores for a query, 0 for all"
    inputBinding:
      position: 1
      prefix: "--keep-top-scores"
  - id: keep_unmatched
    type: ['null', boolean]
    doc: "Keep unmatched query sequence information"
    inputBinding:
      position: 1
      prefix: "--keep-unmatched"
  - id: kmer_dedup_threshold
    type: ['null', int]
    doc: "Remove duplicated kmers for a query with >= X k-mers (default 256)"
    inputBinding:
      position: 1
      prefix: "--kmer-dedup-threshold"
  - id: load_whole_db
    type: ['null', boolean]
    doc: "Load all index files into memory, it is faster for small databases but needs more memory"
    inputBinding:
      position: 1
      prefix: "--load-whole-db"
  - id: low_mem
    type: ['null', boolean]
    doc: "Do not load all index files into memory nor use mmap, the searching would be very very slow for a large number of queries"
    inputBinding:
      position: 1
      prefix: "--low-mem"
  - id: max_fpr
    type: ['null', float]
    doc: "Maximum false positive rate of a query (default 0.01)"
    inputBinding:
      position: 1
      prefix: "--max-fpr"
  - id: min_kmers
    type: ['null', int]
    doc: "Minimum number of matched k-mers (sketches) (default 10)"
    inputBinding:
      position: 1
      prefix: "--min-kmers"
  - id: min_query_cov
    type: ['null', float]
    doc: "Minimum query coverage, i.e., proportion of matched k-mers and unique k-mers of a query (default 0.55)"
    inputBinding:
      position: 1
      prefix: "--min-query-cov"
  - id: min_query_len
    type: ['null', int]
    doc: "Minimum query length (default 30)"
    inputBinding:
      position: 1
      prefix: "--min-query-len"
  - id: min_target_cov
    type: ['null', float]
    doc: "Minimum target coverage, i.e., proportion of matched k-mers and unique k-mers of a target"
    inputBinding:
      position: 1
      prefix: "--min-target-cov"
  - id: name_map
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --name-map
    doc: "Tabular two-column file(s) mapping reference IDs to user-defined values"
    inputBinding:
      position: 1
  - id: no_header_row
    type: ['null', boolean]
    doc: "Do not print header row"
    inputBinding:
      position: 1
      prefix: "--no-header-row"
  - id: out_file
    type: ['null', string]
    default: "kmcp_search.tsv.gz"
    doc: "Out file, supports a \".gz\" suffix (\"-\" for stdout)"
    inputBinding:
      position: 1
      prefix: "--out-file"
  - id: query_id
    type: ['null', string]
    doc: "Custom query Id when using the whole file as a query"
    inputBinding:
      position: 1
      prefix: "--query-id"
  - id: query_whole_file
    type: ['null', boolean]
    doc: "Use the whole file as a query, e.g., for genome similarity estimation against k-mer sketch database"
    inputBinding:
      position: 1
      prefix: "--query-whole-file"
  - id: read1
    type: ['null', File]
    doc: "(Gzipped) read1 file"
    inputBinding:
      position: 1
      prefix: "--read1"
  - id: read2
    type: ['null', File]
    doc: "(Gzipped) read2 file"
    inputBinding:
      position: 1
      prefix: "--read2"
  - id: sort_by
    type: ['null', string]
    doc: "Sort hits by \"qcov\", \"tcov\" or \"jacc\" (Jaccard Index) (default \"qcov\")"
    inputBinding:
      position: 1
      prefix: "--sort-by"
  - id: try_se
    type: ['null', boolean]
    doc: "If paired-end reads have no hits, re-search with read1, if still fails, try read2"
    inputBinding:
      position: 1
      prefix: "--try-se"
  - id: use_filename
    type: ['null', boolean]
    doc: "Use file name as query ID when using the whole file as a query"
    inputBinding:
      position: 1
      prefix: "--use-filename"
  - id: query_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Query files: (gzipped) FASTA/Q files (read1, read2 and unpaired)"
    inputBinding:
      position: 50
  - id: infile_list
    type: ['null', File]
    doc: "File of input files list (one file per line). If given, they are appended to files from CLI arguments. The listed files must be given in infile_list_files"
    inputBinding:
      position: 1
      prefix: "--infile-list"
  - id: infile_list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in infile_list, staged in the working directory"
  - id: log_file
    type: ['null', string]
    doc: "Log file"
    inputBinding:
      position: 1
      prefix: "--log"
  - id: quiet
    type: ['null', boolean]
    doc: "Do not print any verbose information. But you can write them to file with --log"
    inputBinding:
      position: 1
      prefix: "--quiet"
  - id: threads
    type: ['null', int]
    doc: "Number of CPUs cores to use (default 20)"
    inputBinding:
      position: 1
      prefix: "--threads"
outputs:
  - id: out_file_out
    type: ['null', File]
    doc: "Output file written with --out-file"
    outputBinding:
      glob: $(inputs.out_file)
  - id: log
    type: ['null', File]
    doc: "Log file"
    outputBinding:
      glob: $(inputs.log_file)
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.infile_list_files)
      - $(inputs.infile_list)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1
stdout: kmcp_search.out
