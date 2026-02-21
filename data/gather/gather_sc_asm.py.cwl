cwlVersion: v1.2
class: CommandLineTool
baseCommand: gather_sc_asm.py
label: gather_sc_asm.py
doc: "Gather single-cell assembly results (Note: The provided help text contains only
  system error messages and does not list specific tool arguments).\n\nTool homepage:
  https://github.com/Neuroimmunology-UiO/gather"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gather:1.0.1--pyh7e72e81_1
stdout: gather_sc_asm.py.out
