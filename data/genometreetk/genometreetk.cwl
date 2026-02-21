cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometreetk
label: genometreetk
doc: "GenomeTreeTK is a toolkit for phylogenomic analysis, though the provided text
  contains only system error messages regarding container execution and does not list
  specific functional descriptions or arguments.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
stdout: genometreetk.out
