cwlVersion: v1.2
class: CommandLineTool
baseCommand: proftmb
label: proftmb
doc: The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build/fetch process.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/proftmb:v1.1.12-8-deb_cv1
stdout: proftmb.out
