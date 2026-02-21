cwlVersion: v1.2
class: CommandLineTool
baseCommand: gather_tenx_asm.py
label: gather_tenx_asm.py
doc: "A tool for gathering 10x assembly files. (Note: The provided help text contains
  only system error messages and does not list specific arguments or usage instructions.)\n
  \nTool homepage: https://github.com/Neuroimmunology-UiO/gather"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gather:1.0.1--pyh7e72e81_1
stdout: gather_tenx_asm.py.out
