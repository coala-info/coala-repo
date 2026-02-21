cwlVersion: v1.2
class: CommandLineTool
baseCommand: SparCC.py
label: sparcc_SparCC.py
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a failed container build/fetch process.\n\nTool homepage:
  https://bitbucket.org/yonatanf/sparcc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sparcc:0.1.0--0
stdout: sparcc_SparCC.py.out
