cwlVersion: v1.2
class: CommandLineTool
baseCommand: chamois
label: chamois
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it is a log of a failed container build process due to insufficient
  disk space.\n\nTool homepage: https://chamois.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chamois:0.2.1--pyhdfd78af_0
stdout: chamois.out
