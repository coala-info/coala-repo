cwlVersion: v1.2
class: CommandLineTool
baseCommand: optitype_razers3
label: optitype_razers3
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image conversion and disk space.\n\nTool homepage: https://github.com/FRED-2/OptiType"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optitype:1.3.5--hdfd78af_3
stdout: optitype_razers3.out
