cwlVersion: v1.2
class: CommandLineTool
baseCommand: changeo_FilterDb.py
label: changeo_FilterDb.py
doc: "No description available: The provided text is a system error log, not help
  text.\n\nTool homepage: http://changeo.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/changeo:1.3.4--pyhdfd78af_0
stdout: changeo_FilterDb.py.out
