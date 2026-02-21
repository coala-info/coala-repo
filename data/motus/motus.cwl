cwlVersion: v1.2
class: CommandLineTool
baseCommand: motus
label: motus
doc: "The provided text does not contain help documentation for the tool. It contains
  system logs and a fatal error message indicating that the container execution failed
  due to insufficient disk space ('no space left on device').\n\nTool homepage: http://motu-tool.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motus:3.1.0--pyhdfd78af_0
stdout: motus.out
