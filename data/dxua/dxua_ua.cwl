cwlVersion: v1.2
class: CommandLineTool
baseCommand: dxua_ua
label: dxua_ua
doc: "The provided text does not contain help information or usage instructions. It
  consists of environment logs and a fatal error message regarding container image
  building and disk space.\n\nTool homepage: https://documentation.dnanexus.com/user/objects/uploading-and-downloading-files/batch/upload-agent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dxua:1.5.31--0
stdout: dxua_ua.out
