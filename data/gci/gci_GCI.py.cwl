cwlVersion: v1.2
class: CommandLineTool
baseCommand: gci_GCI.py
label: gci_GCI.py
doc: "The provided text does not contain help information or usage instructions; it
  is an error log indicating a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/yeeus/GCI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gci:1.0--hdfd78af_0
stdout: gci_GCI.py.out
