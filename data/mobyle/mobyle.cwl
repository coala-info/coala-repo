cwlVersion: v1.2
class: CommandLineTool
baseCommand: mobyle
label: mobyle
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/tscolari/mobylette"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mobyle:v1.5.5dfsg-6-deb_cv1
stdout: mobyle.out
