cwlVersion: v1.2
class: CommandLineTool
baseCommand: sina
label: sina
doc: "SINA (Structure-based Alignment of Nucleic Acids) is a tool for aligning nucleic
  acid sequences.\n\nTool homepage: https://github.com/epruesse/SINA"
inputs:
  - id: add_relatives
    type:
      - 'null'
      - string
    doc: add the ARG nearest relatives for each sequence to output
    inputBinding:
      position: 101
      prefix: --add-relatives
  - id: db
    type:
      - 'null'
      - File
    doc: reference database
    inputBinding:
      position: 101
      prefix: --db
  - id: fs_engine
    type:
      - 'null'
      - string
    doc: "search engine to use for reference selection \n                        \
      \   [*pt-server*|internal]"
    inputBinding:
      position: 101
      prefix: --fs-engine
  - id: fs_full_len
    type:
      - 'null'
      - int
    doc: minimum length of full length reference
    inputBinding:
      position: 101
      prefix: --fs-full-len
  - id: fs_kmer_len
    type:
      - 'null'
      - int
    doc: length of k-mers
    inputBinding:
      position: 101
      prefix: --fs-kmer-len
  - id: fs_max
    type:
      - 'null'
      - int
    doc: number of references used at most
    inputBinding:
      position: 101
      prefix: --fs-max
  - id: fs_min
    type:
      - 'null'
      - int
    doc: "number of references used regardless of shared \n                      \
      \     fraction"
    inputBinding:
      position: 101
      prefix: --fs-min
  - id: fs_min_len
    type:
      - 'null'
      - int
    doc: minimal reference length
    inputBinding:
      position: 101
      prefix: --fs-min-len
  - id: fs_msc
    type:
      - 'null'
      - float
    doc: required fractional identity of references
    inputBinding:
      position: 101
      prefix: --fs-msc
  - id: fs_req
    type:
      - 'null'
      - int
    doc: "required number of reference sequences (1)\n                           queries
      with less matches will be dropped"
    inputBinding:
      position: 101
      prefix: --fs-req
  - id: fs_req_full
    type:
      - 'null'
      - int
    doc: required number of full length references
    inputBinding:
      position: 101
      prefix: --fs-req-full
  - id: fs_req_gaps
    type:
      - 'null'
      - int
    doc: ignore references with less internal gaps
    inputBinding:
      position: 101
      prefix: --fs-req-gaps
  - id: input_file
    type: File
    doc: input file (arb or fasta)
    inputBinding:
      position: 101
      prefix: --in
  - id: lca_fields
    type:
      - 'null'
      - string
    doc: "names of fields containing source taxonomy (colon \n                   \
      \        separated list)"
    inputBinding:
      position: 101
      prefix: --lca-fields
  - id: lca_quorum
    type:
      - 'null'
      - float
    doc: "fraction of search result that must share resulting \n                 \
      \          classification"
    inputBinding:
      position: 101
      prefix: --lca-quorum
  - id: log_file
    type:
      - 'null'
      - File
    doc: file to write log to
    inputBinding:
      position: 101
      prefix: --log-file
  - id: meta_fmt
    type:
      - 'null'
      - string
    doc: meta data in (*none*|header|comment|csv)
    inputBinding:
      position: 101
      prefix: --meta-fmt
  - id: num_pts
    type:
      - 'null'
      - int
    doc: number of PT servers to start
    inputBinding:
      position: 101
      prefix: --num-pts
  - id: prealigned
    type:
      - 'null'
      - boolean
    doc: skip alignment stage
    inputBinding:
      position: 101
      prefix: --prealigned
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: decrease verbosity
    inputBinding:
      position: 101
      prefix: --quiet
  - id: search
    type:
      - 'null'
      - boolean
    doc: enable search stage
    inputBinding:
      position: 101
      prefix: --search
  - id: search_db
    type:
      - 'null'
      - File
    doc: reference db if different from -r/--db
    inputBinding:
      position: 101
      prefix: --search-db
  - id: search_engine
    type:
      - 'null'
      - string
    doc: engine if different from --fs-engine
    inputBinding:
      position: 101
      prefix: --search-engine
  - id: search_max_result
    type:
      - 'null'
      - int
    doc: desired number of search results
    inputBinding:
      position: 101
      prefix: --search-max-result
  - id: search_min_sim
    type:
      - 'null'
      - float
    doc: required sequence similarity
    inputBinding:
      position: 101
      prefix: --search-min-sim
  - id: threads
    type:
      - 'null'
      - int
    doc: limit number of threads (automatic)
    inputBinding:
      position: 101
      prefix: --threads
  - id: turn
    type:
      - 'null'
      - string
    doc: "check other strand as well\n                           'all' checks all
      four frames"
    inputBinding:
      position: 101
      prefix: --turn
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: increase verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file (arb, fasta or csv; may be specified multiple times)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sina:1.7.2--h9aa86b4_0
