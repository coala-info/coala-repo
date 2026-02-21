cwlVersion: v1.2
class: CommandLineTool
baseCommand: Logex
label: fastk_Logex
doc: "A tool from the FastK suite (Note: The provided help text contains only system
  error messages and no usage information).\n\nTool homepage: https://github.com/thegenemyers/FASTK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_0
stdout: fastk_Logex.out
