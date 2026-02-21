cwlVersion: v1.2
class: CommandLineTool
baseCommand: bctools_convert_bc_to_binary_RY.py
label: bctools_convert_bc_to_binary_RY.py
doc: "Convert barcodes to binary RY format. (Note: The provided text contains system
  error logs regarding a container build failure and does not include the tool's help
  documentation; therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/dmaticzka/bctools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
stdout: bctools_convert_bc_to_binary_RY.py.out
