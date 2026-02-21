cwlVersion: v1.2
class: CommandLineTool
baseCommand: rtk
label: rtk2_rtk
doc: "Rarefaction Tool Kit (RTK) for rarefying and analyzing ecological data. Note:
  The provided text contains container runtime error logs rather than the tool's help
  documentation.\n\nTool homepage: https://github.com/hildebra/rtk2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtk2:2.11.2--h077b44d_1
stdout: rtk2_rtk.out
