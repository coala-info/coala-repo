cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmtools
label: dmtools
doc: "A tool for processing DNA methylation data (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/ZhouQiangwei/dmtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
stdout: dmtools.out
