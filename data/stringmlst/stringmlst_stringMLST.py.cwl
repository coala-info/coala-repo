cwlVersion: v1.2
class: CommandLineTool
baseCommand: stringMLST.py
label: stringmlst_stringMLST.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container build failure.\n\nTool homepage:
  https://github.com/jordanlab/stringMLST"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringmlst:0.6.3--py_0
stdout: stringmlst_stringMLST.py.out
