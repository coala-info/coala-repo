cwlVersion: v1.2
class: CommandLineTool
baseCommand: pfscanV3
label: pftools_pfscanV3
doc: "The provided text does not contain help information for pfscanV3; it contains
  error logs related to a failed container build (no space left on device).\n\nTool
  homepage: https://web.expasy.org/pftools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pftools:3.2.13--pl5321r44hcf78210_0
stdout: pftools_pfscanV3.out
