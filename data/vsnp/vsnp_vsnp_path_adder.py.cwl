cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_vsnp_path_adder.py
label: vsnp_vsnp_path_adder.py
doc: "Using no arguments or -s option show the same output.\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: cwd
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
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_path_adder.py.out
