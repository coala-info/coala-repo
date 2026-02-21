cwlVersion: v1.2
class: CommandLineTool
baseCommand: dreamtools
label: dreamtools
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding container image conversion
  and disk space.\n\nTool homepage: https://github.com/dreamtools/dreamtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dreamtools:1.3.0--py36_0
stdout: dreamtools.out
