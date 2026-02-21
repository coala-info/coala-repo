cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigslice
label: bigslice
doc: "A tool for the analysis of biosynthetic gene clusters (Note: The provided input
  text is an error log from a container build process and does not contain CLI help
  information).\n\nTool homepage: https://github.com/satriaphd/bigslice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigslice:2.0.2--pyh8ed023e_0
stdout: bigslice.out
