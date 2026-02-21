cwlVersion: v1.2
class: CommandLineTool
baseCommand: xmedcon
label: xmedcon
doc: "Medical Image Conversion tool (Note: The provided text is a container engine
  error log and does not contain the tool's help documentation or argument definitions).\n
  \nTool homepage: https://github.com/pld-linux/xmedcon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/xmedcon:v0.16.1dfsg-1-deb_cv1
stdout: xmedcon.out
