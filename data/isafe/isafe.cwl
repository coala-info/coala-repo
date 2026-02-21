cwlVersion: v1.2
class: CommandLineTool
baseCommand: isafe
label: isafe
doc: "Integrated Selection Analysis of Favored Alleles (iSAFE). Note: The provided
  text contains system error messages and does not include usage instructions or argument
  definitions.\n\nTool homepage: https://github.com/alek0991/iSAFE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isafe:1.1.1--pyh5e36f6f_0
stdout: isafe.out
