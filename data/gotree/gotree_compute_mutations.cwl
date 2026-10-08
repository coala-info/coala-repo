cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - compute
  - mutations
label: gotree_compute_mutations
doc: "Extract the list of mutations along the branches of the phylogeny, given.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: alignment
    type: File
    doc: "Alignment input file"
    inputBinding:
      position: 101
      prefix: --align
  - id: eems
    type:
      - 'null'
      - boolean
    doc: "If true, extracts mutations that goes to tips, with their number of emergence (see https://doi.org/10.1101/2021.06.30.450558)"
    inputBinding:
      position: 101
      prefix: --eems
  - id: input_tree
    type: File
    doc: "Input tree"
    inputBinding:
      position: 101
      prefix: --input
  - id: input_strict
    type:
      - 'null'
      - boolean
    doc: "Strict phylip input format (only used with -p)"
    inputBinding:
      position: 101
      prefix: --input-strict
  - id: output_file_path
    type: string
    doc: "Output file"
    inputBinding:
      position: 101
      prefix: --output
  - id: phylip
    type:
      - 'null'
      - boolean
    doc: "Alignment is in phylip? default : false (Fasta)"
    inputBinding:
      position: 101
      prefix: --phylip
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random Seed: -1 = nano seconds since 1970/01/01 00:00:00"
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (Max=20)"
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: "Output file written to the path in output_file_path"
    outputBinding:
      glob: "$(inputs.output_file_path)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
