cwlVersion: v1.2
class: CommandLineTool
baseCommand: ragtag.py
label: ragtag_ragtag.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process.\n\nTool homepage: https://github.com/malonge/RagTag"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
stdout: ragtag_ragtag.py.out
