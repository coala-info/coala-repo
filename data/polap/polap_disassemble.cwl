cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - polap
  - disassemble
label: polap_disassemble
doc: "Disassemble a polap file.\n\nTool homepage: https://github.com/goshng/polap"
inputs:
  - id: input_file
    type: File
    doc: Input polap file
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files without asking
    inputBinding:
      position: 102
      prefix: --force
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save disassembled files
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
stdout: polap_disassemble.out
