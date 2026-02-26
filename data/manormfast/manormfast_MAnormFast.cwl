cwlVersion: v1.2
class: CommandLineTool
baseCommand: MAnormFast
label: manormfast_MAnormFast
doc: "MAnormFast is a tool for analyzing MAnorm data.\n\nTool homepage: https://github.com/semal/MAnormFast"
inputs:
  - id: output_folder
    type: Directory
    doc: The output folder name. If it already exists, an error will be raised.
    inputBinding:
      position: 101
      prefix: --output_folder
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/manormfast:0.1.2--py36_1
stdout: manormfast_MAnormFast.out
