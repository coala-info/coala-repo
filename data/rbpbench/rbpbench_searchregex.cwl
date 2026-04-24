cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbpbench searchregex
label: rbpbench_searchregex
doc: "Search for DNA/RNA motifs using regular expressions in FASTA or BED files.\n\
  \nTool homepage: https://github.com/michauhl/RBPBench"
inputs:
  - id: add_zero_hits
    type:
      - 'null'
      - boolean
    doc: Also add regions with 0 hits to output BED file (hit count in column 5)
    inputBinding:
      position: 101
      prefix: --add-zero-hits
  - id: extension
    type:
      - 'null'
      - string
    doc: Up- and downstream extension of --in sites in nucleotides (nt), if --in
      are genomic regions in BED format. Set e.g. --ext 30 for 30 nt on both 
      sides, or --ext 20,10 for different up- and downstream extension
    inputBinding:
      position: 101
      prefix: --ext
  - id: genome
    type:
      - 'null'
      - File
    doc: Genomic sequences FASTA file (required if --in is BED)
    inputBinding:
      position: 101
      prefix: --genome
  - id: header_id
    type:
      - 'null'
      - string
    doc: Constant header ID part used if --make-uniq-headers set
    inputBinding:
      position: 101
      prefix: --header-id
  - id: input_file
    type: File
    doc: Input FASTA file with DNA/RNA sequences or BED file (>= 6 column 
      format) with genomic regions used for regex search. NOTE that sequences 
      will be converted to DNA and uppercased before search. If BED file, also 
      provide --genome FASTA file
    inputBinding:
      position: 101
      prefix: --in
  - id: make_uniq_headers
    type:
      - 'null'
      - boolean
    doc: Make sequence IDs (FASTA header or BED column 4 IDs) unique. By 
      default, an error is thrown if identical IDs are encountered
    inputBinding:
      position: 101
      prefix: --make-uniq-headers
  - id: regex
    type: string
    doc: Define regular expression (regex) DNA motif used for search, e.g. 
      --regex AAAAA, --regex 'C[ACGT]AC[AC]' .. IUPAC code is also supported, 
      e.g. AAARN resolves to AAA[AG][ACGT]. Moreover, structure patterns can be 
      supplied, e.g. AA((((ARA))))AA or CC(((A...R)))CC with variable spacer. 
      Alternatively, provide a file with regexes (first column regex ID, second 
      column regex), e.g. --regex regexes.txt
    inputBinding:
      position: 101
      prefix: --regex
  - id: regex_max_gu
    type:
      - 'null'
      - float
    doc: Maximum GU (GT) base pair fraction to report structure pattern regex 
      hits
    inputBinding:
      position: 101
      prefix: --regex-max-gu
  - id: regex_min_gc
    type:
      - 'null'
      - float
    doc: Minimum GC base pair fraction to report structure pattern regex hits
    inputBinding:
      position: 101
      prefix: --regex-min-gc
  - id: regex_search_mode
    type:
      - 'null'
      - int
    doc: 'Define regex search mode. 1: when motif hit encountered, continue +1 after
      motif hit start position, 2: when motif hit encountered, continue +1 after motif
      hit end position. NOTE that structure pattern regex currently always uses mode
      1'
    inputBinding:
      position: 101
      prefix: --regex-search-mode
  - id: regex_spacer_max
    type:
      - 'null'
      - int
    doc: Maximum spacer length for structure pattern regex search
    inputBinding:
      position: 101
      prefix: --regex-spacer-max
  - id: regex_spacer_min
    type:
      - 'null'
      - int
    doc: Minimum spacer length for structure pattern regex search
    inputBinding:
      position: 101
      prefix: --regex-spacer-min
outputs:
  - id: output_folder
    type: Directory
    doc: Results output folder
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
