cwlVersion: v1.2
class: CommandLineTool
baseCommand: gafpack
label: gafpack
doc: "A tool for processing GAF (Graph Alignment Format) files. Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/pangenome/gafpack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gafpack:0.1.3--h4349ce8_0
stdout: gafpack.out
