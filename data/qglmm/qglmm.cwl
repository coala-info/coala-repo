cwlVersion: v1.2
class: CommandLineTool
baseCommand: qglmm
label: qglmm
doc: "The provided text is a container build error log and does not contain help documentation
  for the qglmm tool. No arguments could be extracted.\n\nTool homepage: https://github.com/mokar2001/qglmm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qglmm:0.1.1--pyhcf36b3e_0
stdout: qglmm.out
