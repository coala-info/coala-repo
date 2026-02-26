cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_vsnp3_path_adder.py
label: vsnp3_vsnp3_path_adder.py
doc: "vsnp3_path_adder.py is used to add reference types.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Absolute directory path to be added to find reference option files.
    inputBinding:
      position: 101
      prefix: --cwd
  - id: show
    type:
      - 'null'
      - boolean
    doc: Show available directories.
    inputBinding:
      position: 101
      prefix: --show
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_path_adder.py.out
