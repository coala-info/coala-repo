cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastkit_format
label: fastkit_format
doc: "Reformat FASTA files in preparation for tool execution.\n\nTool homepage: https://github.com/neoformit/fastkit"
inputs:
  - id: filename
    type: File
    doc: A filename to parse and correct.
    inputBinding:
      position: 1
  - id: headless
    type:
      - 'null'
      - boolean
    doc: Create a single FASTA sequence from a headless FASTA file
    inputBinding:
      position: 102
      prefix: --headless
  - id: strip_header_space
    type:
      - 'null'
      - boolean
    doc: Strip spaces from title and replace with underscore
    inputBinding:
      position: 102
      prefix: --strip-header-space
  - id: uppercase
    type:
      - 'null'
      - boolean
    doc: Transform all sequence characters to uppercase
    inputBinding:
      position: 102
      prefix: --uppercase
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastkit:1.0.2--pyhdfd78af_0
stdout: fastkit_format.out
