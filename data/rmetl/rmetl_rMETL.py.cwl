cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmetl_rMETL.py
label: rmetl_rMETL.py
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/tjiangHIT/rMETL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rmetl:1.0.4--py_0
stdout: rmetl_rMETL.py.out
