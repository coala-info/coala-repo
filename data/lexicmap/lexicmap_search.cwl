cwlVersion: v1.2
class: CommandLineTool
baseCommand: lexicmap search
label: lexicmap_search
doc: "Search sequences against an index\n\nTool homepage: https://github.com/shenwei356/LexicMap"
inputs:
  - id: query_files
    type:
      type: array
      items: File
    doc: Input FASTA or FASTQ records from files or stdin.
    inputBinding:
      position: 1
  - id: align_band
    type:
      - 'null'
      - int
    doc: Band size in backtracking the score matrix (pseudo alignment phase).
    default: 100
    inputBinding:
      position: 102
      prefix: --align-band
  - id: align_ext_len
    type:
      - 'null'
      - int
    doc: Extend length of upstream and downstream of seed regions, for 
      extracting query and target sequences for alignment. It should be <= 
      contig interval length in database.
    default: 1000
    inputBinding:
      position: 102
      prefix: --align-ext-len
  - id: align_max_gap
    type:
      - 'null'
      - int
    doc: Maximum gap in a HSP segment.
    default: 20
    inputBinding:
      position: 102
      prefix: --align-max-gap
  - id: align_min_match_len
    type:
      - 'null'
      - int
    doc: Minimum aligned length in a HSP segment.
    default: 50
    inputBinding:
      position: 102
      prefix: --align-min-match-len
  - id: align_min_match_pident
    type:
      - 'null'
      - float
    doc: Minimum base identity (percentage) in a HSP segment.
    default: 70
    inputBinding:
      position: 102
      prefix: --align-min-match-pident
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug information, including a progress bar. (recommended when 
      searching with one query).
    inputBinding:
      position: 102
      prefix: --debug
  - id: gc_interval
    type:
      - 'null'
      - int
    doc: Force garbage collection every N queries (0 for disable). The value 
      can't be too small.
    default: 64
    inputBinding:
      position: 102
      prefix: --gc-interval
  - id: genome2taxid_file
    type:
      - 'null'
      - File
    doc: Two-column tabular file for mapping genome ID to TaxId, needed for 
      filtering results with TaxIds. Genome IDs in the index can be exported via
      "lexicmap utils genomes -d db.lmi/ | csvtk cut -t -f 1 | csvtk uniq -Ut"
    inputBinding:
      position: 102
      prefix: --genome2taxid
  - id: index_path
    type: Directory
    doc: Index directory created by "lexicmap index".
    inputBinding:
      position: 102
      prefix: --index
  - id: infile_list
    type:
      - 'null'
      - File
    doc: File of input file list (one file per line). If given, they are 
      appended to files from CLI arguments.
    inputBinding:
      position: 102
      prefix: --infile-list
  - id: keep_genomes_without_taxid
    type:
      - 'null'
      - boolean
    doc: Keep genome hits without TaxId, i.e., those without TaxId in the 
      --genome2taxid file.
    inputBinding:
      position: 102
      prefix: --keep-genomes-without-taxid
  - id: load_whole_seeds
    type:
      - 'null'
      - boolean
    doc: Load the whole seed data into memory for faster seed matching. It will 
      consume a lot of RAM.
    inputBinding:
      position: 102
      prefix: --load-whole-seeds
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file.
    inputBinding:
      position: 102
      prefix: --log
  - id: max_evalue
    type:
      - 'null'
      - float
    doc: Maximum evalue of a HSP segment.
    default: 10
    inputBinding:
      position: 102
      prefix: --max-evalue
  - id: max_open_files
    type:
      - 'null'
      - int
    doc: Maximum opened files. It mainly affects candidate subsequence 
      extraction. Increase this value if you have hundreds of genome batches or 
      have multiple queries, and do not forgot to set a bigger "ulimit -n" in 
      shell if the value is > 1024.
    default: 1024
    inputBinding:
      position: 102
      prefix: --max-open-files
  - id: max_query_conc
    type:
      - 'null'
      - int
    doc: Maximum number of concurrent queries. Bigger values do not improve the 
      batch searching speed and consume much memory.
    default: 8
    inputBinding:
      position: 102
      prefix: --max-query-conc
  - id: min_qcov_per_genome
    type:
      - 'null'
      - float
    doc: Minimum query coverage (percentage) per genome.
    inputBinding:
      position: 102
      prefix: --min-qcov-per-genome
  - id: min_qcov_per_hsp
    type:
      - 'null'
      - float
    doc: Minimum query coverage (percentage) per HSP.
    inputBinding:
      position: 102
      prefix: --min-qcov-per-hsp
  - id: output_all
    type:
      - 'null'
      - boolean
    doc: Output more columns, e.g., matched sequences. Use this if you want to 
      output blast-style format with "lexicmap utils 2blast".
    inputBinding:
      position: 102
      prefix: --all
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print any verbose information. But you can write them to a file 
      with --log.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: seed_max_dist
    type:
      - 'null'
      - int
    doc: Minimum distance between seeds in seed chaining. It should be <= contig
      interval length in database.
    default: 1000
    inputBinding:
      position: 102
      prefix: --seed-max-dist
  - id: seed_max_gap
    type:
      - 'null'
      - int
    doc: Minimum gap in seed chaining.
    default: 50
    inputBinding:
      position: 102
      prefix: --seed-max-gap
  - id: seed_min_prefix
    type:
      - 'null'
      - int
    doc: Minimum (prefix/suffix) length of matched seeds (anchors).
    default: 15
    inputBinding:
      position: 102
      prefix: --seed-min-prefix
  - id: seed_min_single_prefix
    type:
      - 'null'
      - int
    doc: Minimum (prefix/suffix) length of matched seeds (anchors) if there's 
      only one pair of seeds matched.
    default: 17
    inputBinding:
      position: 102
      prefix: --seed-min-single-prefix
  - id: taxdump_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing taxdump files (nodes.dmp, names.dmp, etc.), needed
      for filtering results with TaxIds. For other non-NCBI taxonomy data, 
      please use 'taxonkit create-taxdump' to create taxdump files.
    inputBinding:
      position: 102
      prefix: --taxdump
  - id: taxid_file
    type:
      - 'null'
      - File
    doc: TaxIds from a file for filtering results, where the taxids are equal to
      or are the children of the given taxids. Negative values are allowed as a 
      black list.
    inputBinding:
      position: 102
      prefix: --taxid-file
  - id: taxids
    type:
      - 'null'
      - type: array
        items: string
    doc: TaxIds(s) for filtering results, where the taxids are equal to or are 
      the children of the given taxids. Negative values are allowed as a black 
      list.
    inputBinding:
      position: 102
      prefix: --taxids
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use. By default, it uses all available cores.
    default: 20
    inputBinding:
      position: 102
      prefix: --threads
  - id: top_n_genomes
    type:
      - 'null'
      - int
    doc: Keep top N genome matches for a query (0 for all) in chaining phase. 
      Value 1 is not recommended as the best chaining result does not always 
      bring the best alignment, so it better be >= 100.
    default: 0
    inputBinding:
      position: 102
      prefix: --top-n-genomes
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Out file, supports a ".gz" suffix ("-" for stdout).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
