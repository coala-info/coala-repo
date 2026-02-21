cwlVersion: v1.2
class: CommandLineTool
baseCommand: psass
label: psass
doc: "The provided text does not contain help information or usage instructions for
  the tool 'psass'. It appears to be a log of a failed container image build/fetch
  process.\n\nTool homepage: https://github.com/RomainFeron/PSASS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psass:3.1.0--hf5e1c6e_4
stdout: psass.out
