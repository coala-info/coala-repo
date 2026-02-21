cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-pyvcf
label: python3-pyvcf
doc: The provided text does not contain help information or usage instructions; it
  is an error log from a container build process.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-pyvcf:v0.6.8-1-deb_cv1
stdout: python3-pyvcf.out
