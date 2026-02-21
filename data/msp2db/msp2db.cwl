cwlVersion: v1.2
class: CommandLineTool
baseCommand: msp2db
label: msp2db
doc: "The provided text does not contain help information or usage instructions; it
  is an error log indicating a failure to build a SIF container due to insufficient
  disk space.\n\nTool homepage: https://github.com/computational-metabolomics/msp2db"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msp2db:0.0.9--py_0
stdout: msp2db.out
