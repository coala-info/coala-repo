cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - filter
label: taxonkit_filter
doc: "Filter TaxIds by taxonomic rank range\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: 'File(s) with TaxIds, one per line or in a tab-separated column (see taxid_field)'
    inputBinding:
      position: 1
  - id: black_list
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Black list of ranks to discard, e.g., ''no rank'' and ''clade'''
    inputBinding:
      position: 101
      prefix: --black-list
      itemSeparator: ','
  - id: discard_noranks
    type:
      - 'null'
      - boolean
    doc: 'Discard all ranks without order'
    inputBinding:
      position: 101
      prefix: --discard-noranks
  - id: discard_root
    type:
      - 'null'
      - boolean
    doc: 'Discard root taxid, defined by --root-taxid'
    inputBinding:
      position: 101
      prefix: --discard-root
  - id: equal_to
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Output TaxIds with rank equal to some ranks, e.g., genus and species'
    inputBinding:
      position: 101
      prefix: --equal-to
      itemSeparator: ','
  - id: higher_than
    type:
      - 'null'
      - string
    doc: 'Output TaxIds with rank higher than a rank, exclusive with --lower-than'
    inputBinding:
      position: 101
      prefix: --higher-than
  - id: list_order
    type:
      - 'null'
      - boolean
    doc: 'List user defined ranks in order, from the built-in ranks.txt'
    inputBinding:
      position: 101
      prefix: --list-order
  - id: list_ranks
    type:
      - 'null'
      - boolean
    doc: 'List ordered ranks in taxonomy database, sorted in user defined order'
    inputBinding:
      position: 101
      prefix: --list-ranks
  - id: lower_than
    type:
      - 'null'
      - string
    doc: 'Output TaxIds with rank lower than a rank, exclusive with --higher-than'
    inputBinding:
      position: 101
      prefix: --lower-than
  - id: rank_file
    type:
      - 'null'
      - File
    doc: 'User-defined ordered taxonomic ranks (needed when data_dir is read-only: without it taxonkit tries to write ranks.txt into the data directory)'
    inputBinding:
      position: 101
      prefix: --rank-file
  - id: root_taxid
    type:
      - 'null'
      - int
    doc: 'Root taxid (default 1)'
    inputBinding:
      position: 101
      prefix: --root-taxid
  - id: save_predictable_norank
    type:
      - 'null'
      - boolean
    doc: 'Do not discard some special ranks without order when using --lower-than, where rank of the closest higher node is still lower than rank cutoff'
    inputBinding:
      position: 101
      prefix: --save-predictable-norank
  - id: taxid_field
    type:
      - 'null'
      - int
    doc: 'Field index of taxid. Input data should be tab-separated (default 1)'
    inputBinding:
      position: 101
      prefix: --taxid-field
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory containing nodes.dmp and names.dmp (NCBI taxdump files)'
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: 'Use line buffering on output, i.e., immediately writing to stdin/file for every line of output'
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPUs. 4 is enough'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Print verbose information'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: out_file_path
    type: string
    doc: 'Output file name (suffix .gz for gzipped output)'
    inputBinding:
      position: 102
      prefix: --out-file
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
