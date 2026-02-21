cwlVersion: v1.2
class: CommandLineTool
baseCommand: topas
label: topas
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a log of a failed container build/fetch process.\n\nTool homepage:
  https://github.com/subwaystation/TOPAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/topas:1.0.1--0
stdout: topas.out
