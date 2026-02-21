cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdc-client
label: gdc-client
doc: "The Genomic Data Commons (GDC) Data Transfer Tool.\n\nTool homepage: https://gdc.cancer.gov/access-data/gdc-data-transfer-tool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdc-client:2.3--pyhdfd78af_1
stdout: gdc-client.out
