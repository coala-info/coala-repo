cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdc-client
label: gdc-client_for
doc: "The Genomic Data Commons Command Line Client\n\nTool homepage: https://gdc.cancer.gov/access-data/gdc-data-transfer-tool"
inputs:
  - id: command
    type: string
    doc: The command to execute (download, upload, settings)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdc-client:2.3--pyhdfd78af_1
stdout: gdc-client_for.out
