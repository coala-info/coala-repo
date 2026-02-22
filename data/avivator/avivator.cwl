cwlVersion: v1.2
class: CommandLineTool
baseCommand: avivator
label: avivator
doc: The provided text does not contain help information or usage instructions 
  for the tool 'avivator'. It consists of system error messages related to a 
  failed container image build/retrieval due to insufficient disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/avivator:v0.12.3_cv1
stdout: avivator.out
