cwlVersion: v1.2
class: CommandLineTool
baseCommand: Binsanity-profile
label: binsanity_Binsanity-profile
doc: "Binsanity-profile is a tool within the Binsanity suite, typically used for calculating
  coverage profiles for metagenomic binning. (Note: The provided input text was a
  container execution error log and did not contain the actual help documentation.)\n
  \nTool homepage: https://github.com/edgraham/BinSanity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binsanity:0.5.4--pyh5e36f6f_0
stdout: binsanity_Binsanity-profile.out
