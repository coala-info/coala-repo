cwlVersion: v1.2
class: CommandLineTool
baseCommand: harvesttools
label: harvesttools
doc: "The provided text does not contain help information or usage instructions for
  harvesttools. It appears to be a system error log indicating a failure to build
  a container image due to insufficient disk space.\n\nTool homepage: https://github.com/marbl/harvest-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harvesttools:1.3--ha9fde67_0
stdout: harvesttools.out
