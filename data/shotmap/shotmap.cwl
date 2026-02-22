cwlVersion: v1.2
class: CommandLineTool
baseCommand: shotmap
label: shotmap
doc: "Shotmap is a tool for functional and taxonomic annotation of metagenomic shotgun
  sequencing data. (Note: The provided text contains system error messages regarding
  container instantiation and does not include the tool's help documentation or argument
  definitions.)\n\nTool homepage: https://github.com/sharpton/shotmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/shotmap:v1.0.0_cv3
stdout: shotmap.out
