cwlVersion: v1.2
class: CommandLineTool
baseCommand: export2graphlan.py
label: export2graphlan_export2graphlan.py
doc: "A tool for converting input functional profiles to GraPhlAn input format. (Note:
  The provided help text contains system error logs regarding container execution
  and does not list specific command-line arguments.)\n\nTool homepage: https://github.com/segatalab/export2graphlan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/export2graphlan:0.22--py_0
stdout: export2graphlan_export2graphlan.py.out
