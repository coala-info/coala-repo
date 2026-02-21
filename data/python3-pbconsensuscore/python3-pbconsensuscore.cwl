cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-pbconsensuscore
label: python3-pbconsensuscore
doc: The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build/fetch process.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-pbconsensuscore:v1.0.2-2-deb_cv1
stdout: python3-pbconsensuscore.out
