cwlVersion: v1.2
class: CommandLineTool
baseCommand: lra
label: lra
doc: "Long-read aligner for SMRT and Nanopore reads\n\nTool homepage: https://github.com/ChaissonLab/LRA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lra:1.3.7.2--h5ca1c30_4
stdout: lra.out
