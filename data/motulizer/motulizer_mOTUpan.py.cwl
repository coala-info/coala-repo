cwlVersion: v1.2
class: CommandLineTool
baseCommand: motulizer_mOTUpan.py
label: motulizer_mOTUpan.py
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error regarding container image conversion
  and disk space.\n\nTool homepage: https://github.com/moritzbuck/mOTUlizer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motulizer:0.3.2--pyhdfd78af_0
stdout: motulizer_mOTUpan.py.out
