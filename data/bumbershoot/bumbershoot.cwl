cwlVersion: v1.2
class: CommandLineTool
baseCommand: bumbershoot
label: bumbershoot
doc: "Bumbershoot is a software suite for proteomics data analysis, including tools
  like MyriMatch, IDPicker, and DirecTag. (Note: The provided text contains system
  error messages regarding container execution and does not include the tool's help
  documentation.)\n\nTool homepage: https://github.com/michaelcmartin/bumbershoot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bumbershoot:3_0_21142_0e4f4a4--h7d875b9_0
stdout: bumbershoot.out
