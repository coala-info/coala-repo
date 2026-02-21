cwlVersion: v1.2
class: CommandLineTool
baseCommand: dxua
label: dxua
doc: "A tool for processing data, likely within a bioinformatics context (based on
  the container source), though the provided text contains only execution logs and
  error messages rather than help documentation.\n\nTool homepage: https://documentation.dnanexus.com/user/objects/uploading-and-downloading-files/batch/upload-agent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dxua:1.5.31--0
stdout: dxua.out
