cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ska
  - nk
label: ska2_nk
doc: "Get the number of k-mers in a split k-mer file, and other information\n\nTool homepage: https://github.com/bacpop/ska.rust"
inputs:
  - id: skf_file
    type: File
    doc: 'Split-kmer (.skf) file to operate on'
    inputBinding:
      position: 1
  - id: full_info
    type:
      - 'null'
      - boolean
    doc: 'Also write out split-kmers, and middle base matrix'
    inputBinding:
      position: 101
      prefix: --full-info
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Show progress messages'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: 'Standard output'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
stdout: ska2_nk.out
