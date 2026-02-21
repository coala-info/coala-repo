cwlVersion: v1.2
class: CommandLineTool
baseCommand: kalign
label: kalign
doc: "The provided text does not contain help information or usage instructions for
  kalign; it is a system error message indicating a failure to build a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/TimoLassmann/kalign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kalign:v1-2.0320110620-5-deb_cv1
stdout: kalign.out
