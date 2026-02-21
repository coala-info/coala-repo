cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools
doc: "The provided text does not contain help information for wiggletools; it contains
  container runtime logs and a fatal error message regarding a failure to fetch the
  OCI image.\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
stdout: wiggletools.out
