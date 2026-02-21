cwlVersion: v1.2
class: CommandLineTool
baseCommand: dfam
label: dfam
doc: "Dfam is a database of repetitive DNA elements (TEs) and other repetitive sequences.\n
  \nTool homepage: dfam.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dfam:3.7--hdfd78af_0
stdout: dfam.out
