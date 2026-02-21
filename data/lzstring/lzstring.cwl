cwlVersion: v1.2
class: CommandLineTool
baseCommand: lzstring
label: lzstring
doc: "LZ-based compression utility (Note: The provided help text contains only container
  execution errors and does not list specific command-line arguments).\n\nTool homepage:
  https://github.com/diogoduailibe/lzstring4j"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/lzstring:v1.0.4-1-deb-py3_cv1
stdout: lzstring.out
