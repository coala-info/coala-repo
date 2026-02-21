cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaquast
label: rnaquast
doc: "rnaQUAST: Quality Assessment Tool for RNA-seq Assemblies\n\nTool homepage: http://cab.spbu.ru/software/rnaquast/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaquast:2.3.0--h9ee0642_0
stdout: rnaquast.out
