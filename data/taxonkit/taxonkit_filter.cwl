cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - filter
label: taxonkit_filter
doc: "Filter TaxIds by taxonomic rank range\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: black_list
    type:
      - 'null'
      - type: array
        items: string
    doc: black list of ranks to discard, e.g., '-B "no rank" -B "clade"'
    inputBinding:
      position: 101
      prefix: --black-list
  - id: data_dir
    type:
      - 'null'
      - string
    doc: directory containing nodes.dmp and names.dmp
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: discard_noranks
    type:
      - 'null'
      - boolean
    doc: discard all ranks without order, type "taxonkit filter --help" for 
      details
    inputBinding:
      position: 101
      prefix: --discard-noranks
  - id: discard_root
    type:
      - 'null'
      - boolean
    doc: discard root taxid, defined by --root-taxid
    inputBinding:
      position: 101
      prefix: --discard-root
  - id: equal_to
    type:
      - 'null'
      - type: array
        items: string
    doc: output TaxIds with rank equal to some ranks, multiple values can be 
      separated with comma "," (e.g., -E "genus,species"), or give multiple 
      times (e.g., -E genus -E species)
    inputBinding:
      position: 101
      prefix: --equal-to
  - id: higher_than
    type:
      - 'null'
      - string
    doc: output TaxIds with rank higher than a rank, exclusive with --lower-than
    inputBinding:
      position: 101
      prefix: --higher-than
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: use line buffering on output, i.e., immediately writing to stdin/file 
      for every line of output
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: list_order
    type:
      - 'null'
      - boolean
    doc: list user defined ranks in order, from "$HOME/.taxonkit/ranks.txt"
    inputBinding:
      position: 101
      prefix: --list-order
  - id: list_ranks
    type:
      - 'null'
      - boolean
    doc: list ordered ranks in taxonomy database, sorted in user defined order
    inputBinding:
      position: 101
      prefix: --list-ranks
  - id: lower_than
    type:
      - 'null'
      - string
    doc: output TaxIds with rank lower than a rank, exclusive with --higher-than
    inputBinding:
      position: 101
      prefix: --lower-than
  - id: rank_file
    type:
      - 'null'
      - string
    doc: user-defined ordered taxonomic ranks, type "taxonkit filter --help" for
      details
    inputBinding:
      position: 101
      prefix: --rank-file
  - id: root_taxid
    type:
      - 'null'
      - int
    doc: root taxid
    inputBinding:
      position: 101
      prefix: --root-taxid
  - id: save_predictable_norank
    type:
      - 'null'
      - boolean
    doc: do not discard some special ranks without order when using -L, where 
      rank of the closest higher node is still lower than rank cutoff
    inputBinding:
      position: 101
      prefix: --save-predictable-norank
  - id: taxid_field
    type:
      - 'null'
      - int
    doc: field index of taxid. input data should be tab-separated
    inputBinding:
      position: 101
      prefix: --taxid-field
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. 4 is enough
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
