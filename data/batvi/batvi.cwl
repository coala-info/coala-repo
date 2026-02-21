cwlVersion: v1.2
class: CommandLineTool
baseCommand: batvi
label: batvi
doc: "The provided text contains error logs related to a container build failure ('no
  space left on device') and does not contain help documentation or usage instructions
  for the tool 'batvi'. As a result, no arguments could be extracted.\n\nTool homepage:
  https://www.comp.nus.edu.sg/~bioinfo/batvi/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/batvi:1.04--h5b5514e_7
stdout: batvi.out
