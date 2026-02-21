cwlVersion: v1.2
class: CommandLineTool
baseCommand: ashleys-qc
label: ashleys-qc
doc: "The provided text is an error log and does not contain help documentation for
  ashleys-qc. No arguments could be parsed.\n\nTool homepage: https://github.com/friendsofstrandseq/ashleys-qc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ashleys-qc:0.2.1--pyh7cba7a3_0
stdout: ashleys-qc.out
