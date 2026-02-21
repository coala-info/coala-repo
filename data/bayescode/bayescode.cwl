cwlVersion: v1.2
class: CommandLineTool
baseCommand: bayescode
label: bayescode
doc: "A tool for Bayesian inference of protein evolution (Note: The provided help
  text contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/ThibaultLatrille/bayescode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayescode:1.3.4--h9948957_0
stdout: bayescode.out
