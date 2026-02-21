cwlVersion: v1.2
class: CommandLineTool
baseCommand: binette_checkm2
label: binette_checkm2
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding disk space during a container build
  process.\n\nTool homepage: https://github.com/genotoul-bioinfo/binette"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binette:1.2.1--pyh7e72e81_0
stdout: binette_checkm2.out
