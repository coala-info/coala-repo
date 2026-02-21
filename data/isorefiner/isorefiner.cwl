cwlVersion: v1.2
class: CommandLineTool
baseCommand: isorefiner
label: isorefiner
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding disk space during a container
  image pull.\n\nTool homepage: https://github.com/rkajitani/IsoRefiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
stdout: isorefiner.out
