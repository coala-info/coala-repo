cwlVersion: v1.2
class: CommandLineTool
baseCommand: coolpuppy
label: coolpuppy
doc: "A tool for pileup analysis of Hi-C data (Note: The provided text contains system
  error messages and does not include the standard help documentation for argument
  extraction).\n\nTool homepage: https://github.com/open2c/coolpuppy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coolpuppy:1.1.0--pyh086e186_0
stdout: coolpuppy.out
