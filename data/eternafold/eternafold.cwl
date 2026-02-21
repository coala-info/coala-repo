cwlVersion: v1.2
class: CommandLineTool
baseCommand: eternafold
label: eternafold
doc: "A tool for RNA secondary structure prediction. (Note: The provided help text
  contains system error messages regarding container execution and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/eternagame/EternaFold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eternafold:1.3.1--h9948957_1
stdout: eternafold.out
