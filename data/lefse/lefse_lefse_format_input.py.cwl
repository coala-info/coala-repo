cwlVersion: v1.2
class: CommandLineTool
baseCommand: lefse_format_input.py
label: lefse_lefse_format_input.py
doc: "The provided text does not contain help information as the tool failed to execute
  due to a system error (no space left on device).\n\nTool homepage: https://github.com/SegataLab/lefse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
stdout: lefse_lefse_format_input.py.out
