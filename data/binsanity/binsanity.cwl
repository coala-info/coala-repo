cwlVersion: v1.2
class: CommandLineTool
baseCommand: binsanity
label: binsanity
doc: "BinSanity is a tool for refining and clustering metagenomic bins. (Note: The
  provided text appears to be a system error log rather than help text, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/edgraham/BinSanity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
stdout: binsanity.out
