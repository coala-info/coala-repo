cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - delete
label: ska2_delete
doc: "Remove samples from a split k-mer file\n\nTool homepage: https://github.com/bacpop/ska.rust"
inputs:
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of sample names to remove'
    inputBinding:
      position: 1
  - id: skf_file
    type: File
    doc: 'Split-kmer (.skf) file to operate on'
    inputBinding:
      position: 101
      prefix: --skf-file
  - id: file_list
    type:
      - 'null'
      - File
    doc: 'File listing sample names to remove'
    inputBinding:
      position: 101
      prefix: -f
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Show progress messages'
    inputBinding:
      position: 101
      prefix: -v
  - id: output_name
    type: string
    doc: 'Output name. If not provided, will overwrite the input file'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_skf
    type: File
    doc: 'Split-kmer file without the removed samples'
    outputBinding:
      glob: '$(inputs.output_name)*'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
