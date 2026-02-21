cwlVersion: v1.2
class: CommandLineTool
baseCommand: sapling
label: sapling
doc: "A tool for genomic data analysis (Note: The provided text is an error log and
  does not contain usage information or argument definitions).\n\nTool homepage: https://github.com/elkebir-group/Sapling"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sapling:1.0.0--pyhdfd78af_0
stdout: sapling.out
