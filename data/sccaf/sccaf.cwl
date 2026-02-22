cwlVersion: v1.2
class: CommandLineTool
baseCommand: sccaf
label: sccaf
doc: "Single Cell Cluster Assessment Framework\n\nTool homepage: https://github.com/SCCAF/sccaf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sccaf:0.0.10--py_0
stdout: sccaf.out
