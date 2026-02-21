cwlVersion: v1.2
class: CommandLineTool
baseCommand: Binsanity-lc
label: binsanity_Binsanity-lc
doc: "Binsanity-lc is a tool for refinement of bins using a density-based clustering
  approach. (Note: The provided help text contains only system error logs and does
  not list specific arguments.)\n\nTool homepage: https://github.com/edgraham/BinSanity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
stdout: binsanity_Binsanity-lc.out
