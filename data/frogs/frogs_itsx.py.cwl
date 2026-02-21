cwlVersion: v1.2
class: CommandLineTool
baseCommand: frogs_itsx.py
label: frogs_itsx.py
doc: "The provided text does not contain help information for frogs_itsx.py; it contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: frogs_itsx.py.out
