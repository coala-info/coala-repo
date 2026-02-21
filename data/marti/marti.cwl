cwlVersion: v1.2
class: CommandLineTool
baseCommand: marti
label: marti
doc: "MARTi (Metagenomics Analysis in Real-Time)\n\nTool homepage: https://github.com/richardmleggett/MARTi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marti:0.9.29--hdfd78af_0
stdout: marti.out
