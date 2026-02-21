cwlVersion: v1.2
class: CommandLineTool
baseCommand: psauron
label: psauron
doc: "The provided text does not contain help information or usage instructions for
  the tool; it consists of container runtime logs and a fatal error message during
  an image build process.\n\nTool homepage: https://github.com/salzberg-lab/PSAURON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psauron:1.1.0--pyhdfd78af_0
stdout: psauron.out
