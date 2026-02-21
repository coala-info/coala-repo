cwlVersion: v1.2
class: CommandLineTool
baseCommand: beav
label: beav
doc: "Binary Editor And Viewer (Note: The provided text is a system error log regarding
  a container build failure and does not contain the tool's help documentation or
  argument definitions).\n\nTool homepage: https://github.com/weisberglab/beav"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beav:1.4.0--hdfd78af_1
stdout: beav.out
