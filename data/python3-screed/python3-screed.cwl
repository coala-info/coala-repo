cwlVersion: v1.2
class: CommandLineTool
baseCommand: screed
label: python3-screed
doc: The provided text does not contain help documentation or usage instructions for
  the tool. It appears to be a log of a failed container build/fetch process.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-screed:v0.9-2-deb_cv1
stdout: python3-screed.out
