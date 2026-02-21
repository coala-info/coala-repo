cwlVersion: v1.2
class: CommandLineTool
baseCommand: artic
label: artic
doc: "The provided text does not contain help information or usage instructions for
  the 'artic' tool. It consists of system log messages and a fatal error regarding
  a container build failure (no space left on device).\n\nTool homepage: https://github.com/artic-network/fieldbioinformatics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic:1.8.5--pyhdfd78af_0
stdout: artic.out
