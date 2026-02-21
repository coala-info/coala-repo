cwlVersion: v1.2
class: CommandLineTool
baseCommand: genbank
label: genbank
doc: "The provided text does not contain help information or usage instructions. It
  consists of container runtime log messages and a fatal error indicating a failure
  to build the SIF format due to lack of disk space.\n\nTool homepage: https://github.com/deprekate/genbank"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genbank:0.121--py313h366bbf7_1
stdout: genbank.out
