cwlVersion: v1.2
class: CommandLineTool
baseCommand: blobtk
label: blobtk
doc: "A toolkit for processing BlobToolKit data. (Note: The provided text contains
  system error messages and does not list specific command-line arguments or usage
  instructions.)\n\nTool homepage: https://github.com/genomehubs/blobtk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtk:0.7.1--py39hf6b2c50_0
stdout: blobtk.out
