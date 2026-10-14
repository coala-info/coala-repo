cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyling
  - filter
label: phyling_filter
doc: "Filter the multiple sequence alignment (MSA) results for tree module.\n\nTool
  homepage: https://github.com/stajichlab/Phyling"
inputs:
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing multiple sequence alignment fasta of the markers
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: inputs
    type:
      - 'null'
      - type: array
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
    inputBinding:
      position: 101
      prefix: --seqtype
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads for filtering
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
  - id: output_directory_path
    type: string
    doc: 'directory Output directory of the treeness.tsv and selected MSAs (default:
      phyling-tree-[YYYYMMDD-HHMMSS] (UTC timestamp))'
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory of the treeness.tsv and selected MSAs
    outputBinding:
      glob: $(inputs.output_directory_path)
arguments:
  - position: 200
    shellQuote: false
    valueFrom: >-
      && find $(inputs.output_directory_path) -type l -exec sh -c 'cp --remove-destination "`readlink -f "$1"`" "$1"' _ {} \;
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.inputs)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyling:2.3.1--pyhdfd78af_0
