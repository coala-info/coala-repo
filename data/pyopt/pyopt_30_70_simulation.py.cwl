cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyopt_30_70_simulation.py
label: pyopt_30_70_simulation.py
doc: "A simulation tool (Note: The provided text contained container build errors
  rather than help documentation, so no arguments could be extracted).\n\nTool homepage:
  https://github.com/boyac/pyOptionPricing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyopt:1.2.0--py27_1
stdout: pyopt_30_70_simulation.py.out
