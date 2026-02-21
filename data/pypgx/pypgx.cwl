cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgx
label: pypgx
doc: "A Python package for pharmacogenomics (PGx) research.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
stdout: pypgx.out
