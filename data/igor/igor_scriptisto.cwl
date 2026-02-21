cwlVersion: v1.2
class: CommandLineTool
baseCommand: igor_scriptisto
label: igor_scriptisto
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image conversion and disk space.\n\nTool homepage: https://github.com/igor-petruk/scriptisto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/igor:v1.3.0dfsg-1-deb_cv1
stdout: igor_scriptisto.out
