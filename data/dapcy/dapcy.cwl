cwlVersion: v1.2
class: CommandLineTool
baseCommand: dapcy
label: dapcy
doc: "Differential Analysis of Protein-Coding Yield (Note: The provided text is an
  error log from a container build and does not contain usage instructions or argument
  definitions.)\n\nTool homepage: https://gitlab.com/uhasselt-bioinfo/dapcy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dapcy:1.3.1--pyhdfd78af_0
stdout: dapcy.out
