cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-burrito
label: python3-burrito
doc: The provided text does not contain help information or a description of the tool;
  it appears to be a container engine error log.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-burrito:v0.9.1-1-deb_cv1
stdout: python3-burrito.out
