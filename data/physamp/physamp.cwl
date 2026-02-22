cwlVersion: v1.2
class: CommandLineTool
baseCommand: physamp
label: physamp
doc: "The provided text is an error log from a container runtime and does not contain
  the help documentation for the tool. No usage information or arguments could be
  extracted.\n\nTool homepage: https://github.com/jydu/physamp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/physamp:v1.1.0-1-deb_cv1
stdout: physamp.out
