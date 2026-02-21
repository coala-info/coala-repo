cwlVersion: v1.2
class: CommandLineTool
baseCommand: superintervals
label: superintervals
doc: "A tool for performing operations on genomic intervals, typically distributed
  as a biocontainer.\n\nTool homepage: https://github.com/kcleal/superintervals"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/superintervals:0.3.5--py39he88f293_0
stdout: superintervals.out
