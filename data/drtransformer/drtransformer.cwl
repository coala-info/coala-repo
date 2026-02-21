cwlVersion: v1.2
class: CommandLineTool
baseCommand: drtransformer
label: drtransformer
doc: "A tool for predicting cotranscriptional folding pathways (Note: The provided
  input text contains container runtime error logs rather than the tool's help documentation).\n
  \nTool homepage: https://pypi.org/project/drtransformer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drtransformer:1.0--pyhdfd78af_0
stdout: drtransformer.out
