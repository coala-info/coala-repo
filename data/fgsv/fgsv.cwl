cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgsv
label: fgsv
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error messages regarding disk space.\n\nTool
  homepage: https://github.com/fulcrumgenomics/fgsv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgsv:0.2.1--hdfd78af_1
stdout: fgsv.out
