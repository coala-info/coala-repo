cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - merge
label: ska2_merge
doc: "Combine multiple split k-mer files\n\nTool homepage: https://github.com/bacpop/ska.rust"
inputs:
  - id: skf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'List of input split-kmer (.skf) files'
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Show progress messages'
    inputBinding:
      position: 101
      prefix: -v
  - id: output_prefix
    type: string
    doc: 'Output prefix (.skf is added)'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: merged_skf
    type: File
    doc: 'Merged split-kmer file'
    outputBinding:
      glob: '$(inputs.output_prefix).skf'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
