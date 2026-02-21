cwlVersion: v1.2
class: CommandLineTool
baseCommand: staden-common
label: staden-common
doc: The provided text does not contain help documentation or usage instructions;
  it appears to be a log of a failed container build process.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/staden-common:v2.0.0b11-4-deb_cv1
stdout: staden-common.out
