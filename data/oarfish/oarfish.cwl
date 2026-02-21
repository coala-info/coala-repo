cwlVersion: v1.2
class: CommandLineTool
baseCommand: oarfish
label: oarfish
doc: "The provided text does not contain help information or usage instructions for
  the tool 'oarfish'. It contains system log messages and a fatal error regarding
  a container build failure (no space left on device).\n\nTool homepage: https://github.com/COMBINE-lab/oarfish"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oarfish:0.9.3--h5ca1c30_0
stdout: oarfish.out
