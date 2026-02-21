cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-skbio
label: python3-skbio
doc: The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build or fetch operation.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-skbio:v0.5.1-2-deb_cv1
stdout: python3-skbio.out
