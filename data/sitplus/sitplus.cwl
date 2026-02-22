cwlVersion: v1.2
class: CommandLineTool
baseCommand: sitplus
label: sitplus
doc: "SITPLUS (Software for Interactive Transformation) is a tool for the creation
  of interactive environments. (Note: The provided text contains system error logs
  regarding container execution and does not include specific command-line argument
  definitions.)\n\nTool homepage: https://github.com/luinix/sitplus-debian"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sitplus:v1.0.3-5.1-deb_cv1
stdout: sitplus.out
