cwlVersion: v1.2
class: CommandLineTool
baseCommand: profnet-chop
label: profnet-chop
doc: The provided text does not contain help information or usage instructions for
  the tool; it is a log of a failed container build/fetch operation.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profnet-chop:v1.0.22-6-deb_cv1
stdout: profnet-chop.out
