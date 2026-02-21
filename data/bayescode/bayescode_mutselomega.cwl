cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutselomega
label: bayescode_mutselomega
doc: "A tool within the BayesCode package. (Note: The provided input text contains
  system error logs regarding a container build failure and does not contain the actual
  help text or usage instructions for the tool.)\n\nTool homepage: https://github.com/ThibaultLatrille/bayescode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayescode:1.3.4--h9948957_0
stdout: bayescode_mutselomega.out
