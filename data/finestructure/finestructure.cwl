cwlVersion: v1.2
class: CommandLineTool
baseCommand: finestructure
label: finestructure
doc: "A tool for population structure analysis. (Note: The provided input text contains
  container runtime error messages and does not include the tool's help documentation
  or usage instructions.)\n\nTool homepage: https://people.maths.bris.ac.uk/~madjl/finestructure/finestructure.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finestructure:4.1.1--pl5321hdfd78af_0
stdout: finestructure.out
