cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-dendropy
label: python3-dendropy
doc: The provided text does not contain help information for the tool; it appears
  to be a container build error log.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-dendropy:v4.2.0dfsg-1-deb_cv1
stdout: python3-dendropy.out
