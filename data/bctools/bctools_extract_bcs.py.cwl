cwlVersion: v1.2
class: CommandLineTool
baseCommand: bctools_extract_bcs.py
label: bctools_extract_bcs.py
doc: "The provided text does not contain help information for the tool, but rather
  a system error log related to a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/dmaticzka/bctools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
stdout: bctools_extract_bcs.py.out
