cwlVersion: v1.2
class: CommandLineTool
baseCommand: vembrane
label: vembrane
doc: "Vembrane is a tool for filtering and manipulating VCF files using Python expressions.
  (Note: The provided text appears to be a container execution error log rather than
  help text; therefore, no arguments could be extracted from the input.)\n\nTool homepage:
  https://github.com/vembrane/vembrane"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vembrane:2.4.0--pyhdfd78af_0
stdout: vembrane.out
