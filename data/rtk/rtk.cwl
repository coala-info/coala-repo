cwlVersion: v1.2
class: CommandLineTool
baseCommand: rtk
label: rtk
doc: "Rarefaction Tool Kit (Note: The provided text contains container build logs
  and error messages rather than the tool's help documentation. No arguments could
  be extracted.)\n\nTool homepage: https://github.com/hildebra/Rarefaction/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtk:0.93.2--h077b44d_6
stdout: rtk.out
