cwlVersion: v1.2
class: CommandLineTool
baseCommand: cartools
label: cartools
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log related to a container build failure (no space
  left on device).\n\nTool homepage: https://github.com/clinical-genomics-uppsala/CARtool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cartools:1.1.3--pyh7cba7a3_0
stdout: cartools.out
