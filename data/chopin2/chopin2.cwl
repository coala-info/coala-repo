cwlVersion: v1.2
class: CommandLineTool
baseCommand: chopin2
label: chopin2
doc: "CHOPIN2 (CHOPping INformation) is a tool for feature selection and data dimensionality
  reduction. (Note: The provided text was an error log and did not contain help information;
  arguments could not be extracted from the input.)\n\nTool homepage: https://github.com/cumbof/chopin2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chopin2:1.0.9.post1
stdout: chopin2.out
