cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-fastcluster
label: python3-fastcluster
doc: The provided text does not contain help information for the tool. It contains
  error logs related to a container image build failure.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-fastcluster:v1.1.22-1-deb_cv1
stdout: python3-fastcluster.out
