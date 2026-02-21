cwlVersion: v1.2
class: CommandLineTool
baseCommand: moss_post_filter.py
label: moss_post_filter.py
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build a container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/elkebir-group/Moss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moss:0.1.1--h84372a0_6
stdout: moss_post_filter.py.out
