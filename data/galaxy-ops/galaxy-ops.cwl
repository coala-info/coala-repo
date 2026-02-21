cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-ops
label: galaxy-ops
doc: "A tool from the Galaxy project for performing operations on genomic intervals.\n
  \nTool homepage: https://github.com/galaxyproject/gops"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-ops:1.1.0--py27_0
stdout: galaxy-ops.out
