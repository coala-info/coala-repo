cwlVersion: v1.2
class: CommandLineTool
baseCommand: Binsanity
label: binsanity_Binsanity2-beta
doc: "Binsanity is a tool for refining and clustering environmental genomic data.
  (Note: The provided help text contained only system error messages and no usage
  information; arguments could not be extracted.)\n\nTool homepage: https://github.com/edgraham/BinSanity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
stdout: binsanity_Binsanity2-beta.out
