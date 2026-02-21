cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pancake
  - status
label: pancake_status
doc: "Check the status of a PAN_FILE\n\nTool homepage: https://github.com/pancakeswap/pancake-frontend"
inputs:
  - id: pan_file
    type: File
    doc: The PAN_FILE to check the status of
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pancake:1.1.2--py35_0
stdout: pancake_status.out
