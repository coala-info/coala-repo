cwlVersion: v1.2
class: CommandLineTool
baseCommand: nda-tools
label: nda-tools
doc: "The provided text does not contain help information or documentation for nda-tools.
  It contains system log messages and a fatal error regarding container image conversion
  and disk space.\n\nTool homepage: https://github.com/NDAR/nda-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nda-tools:0.6.0--pyh7e72e81_0
stdout: nda-tools.out
