cwlVersion: v1.2
class: CommandLineTool
baseCommand: quickmerge_merge_wrapper.py
label: quickmerge_merge_wrapper.py
doc: "A wrapper script for the quickmerge tool. Note: The provided help text contains
  only system error logs and does not list specific arguments or usage instructions.\n
  \nTool homepage: https://github.com/mahulchak/quickmerge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quickmerge:0.3--pl5321h503566f_6
stdout: quickmerge_merge_wrapper.py.out
