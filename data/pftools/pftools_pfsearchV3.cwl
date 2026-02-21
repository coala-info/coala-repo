cwlVersion: v1.2
class: CommandLineTool
baseCommand: pfsearchV3
label: pftools_pfsearchV3
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container build failure (no space left
  on device).\n\nTool homepage: https://web.expasy.org/pftools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pftools:3.2.13--pl5321r44hcf78210_0
stdout: pftools_pfsearchV3.out
