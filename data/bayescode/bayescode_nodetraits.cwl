cwlVersion: v1.2
class: CommandLineTool
baseCommand: bayescode_nodetraits
label: bayescode_nodetraits
doc: "A tool within the BayesCode package. (Note: The provided text contains container
  build errors and does not include the actual help documentation for the tool's arguments.)\n
  \nTool homepage: https://github.com/ThibaultLatrille/bayescode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayescode:1.3.4--h9948957_0
stdout: bayescode_nodetraits.out
