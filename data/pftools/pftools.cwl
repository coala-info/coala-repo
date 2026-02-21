cwlVersion: v1.2
class: CommandLineTool
baseCommand: pftools
label: pftools
doc: "The provided text is a container build error log and does not contain help information
  or usage instructions for the tool.\n\nTool homepage: https://web.expasy.org/pftools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pftools:3.2.13--pl5321r44hcf78210_0
stdout: pftools.out
