cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyling filter
label: phyling_filter
doc: "Filter the multiple sequence alignment (MSA) results for tree module.\n\nTool
  homepage: https://github.com/stajichlab/Phyling"
inputs:
  - id: input_dir
    type: Directory
    doc: Directory containing multiple sequence alignment fasta of the markers
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: inputs
    type:
      type: array
      items: File
    doc: Multiple sequence alignment fasta of the markers
    inputBinding:
      position: 101
      prefix: --inputs
  - id: ml
    type:
      - 'null'
      - boolean
    doc: Use maximum-likelihood estimation during tree building
    inputBinding:
      position: 101
      prefix: --ml
  - id: seqtype
    type:
      - 'null'
      - string
    doc: Input data sequence type
    default: AUTO
    inputBinding:
      position: 101
      prefix: --seqtype
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads for filtering
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: top_n_toverr
    type: int
    doc: Select the top n markers based on their treeness/RCV for final tree 
      building
    inputBinding:
      position: 101
      prefix: --top_n_toverr
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode for debug
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory of the treeness.tsv and selected MSAs
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyling:2.3.1--pyhdfd78af_0
