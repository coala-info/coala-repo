cwlVersion: v1.2
class: CommandLineTool
baseCommand: MirMachine.py
label: mirmachine_MirMachine.py
doc: "MirMachine is a tool for miRNA gene prediction in genome sequences.\n\nTool
  homepage: https://github.com/sinanugur/MirMachine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirmachine:0.3.0.2--pyhdfd78af_0
stdout: mirmachine_MirMachine.py.out
