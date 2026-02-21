cwlVersion: v1.2
class: CommandLineTool
baseCommand: Binsanity-refine
label: binsanity_Binsanity-refine
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build a container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/edgraham/BinSanity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
stdout: binsanity_Binsanity-refine.out
