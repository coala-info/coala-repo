cwlVersion: v1.2
class: CommandLineTool
baseCommand: rtk2
label: rtk2
doc: "Rarefaction Tool Kit 2 (Note: The provided text contains container build logs
  rather than command-line help documentation. No arguments could be extracted.)\n
  \nTool homepage: https://github.com/hildebra/rtk2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtk2:2.11.2--h077b44d_1
stdout: rtk2.out
