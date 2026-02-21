cwlVersion: v1.2
class: CommandLineTool
baseCommand: kineticstools-data
label: kineticstools-data
doc: 'Data package for kineticstools. Note: The provided text contains system error
  messages regarding container image acquisition and does not include specific CLI
  usage instructions or arguments.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kineticstools-data:v0.6.120161222-1-deb_cv1
stdout: kineticstools-data.out
