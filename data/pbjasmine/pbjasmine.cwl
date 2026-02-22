cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbjasmine
label: pbjasmine
doc: "The provided text does not contain help information for pbjasmine; it contains
  system error messages regarding disk space and container image retrieval.\n\nTool
  homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbjasmine:2.7.99--h9948957_0
stdout: pbjasmine.out
