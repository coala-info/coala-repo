cwlVersion: v1.2
class: CommandLineTool
baseCommand: espresso_create_corrected_sam.py
label: espresso_create_corrected_sam.py
doc: "The provided text does not contain help information for the tool; it consists
  of system error messages regarding a container runtime failure (no space left on
  device).\n\nTool homepage: https://github.com/Xinglab/espresso"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/espresso:1.6.0--pl5321h5ca1c30_1
stdout: espresso_create_corrected_sam.py.out
