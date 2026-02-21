cwlVersion: v1.2
class: CommandLineTool
baseCommand: eternafold
label: eternafold_contrafold
doc: "RNA secondary structure prediction tool. (Note: The provided text is a system
  error log regarding container image conversion and does not contain usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/eternagame/EternaFold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eternafold:1.3.1--h9948957_1
stdout: eternafold_contrafold.out
