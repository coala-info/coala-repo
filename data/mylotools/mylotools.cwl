cwlVersion: v1.2
class: CommandLineTool
baseCommand: mylotools
label: mylotools
doc: "The provided text does not contain help information or usage instructions for
  mylotools; it contains system log messages and a fatal error regarding disk space
  during a container build.\n\nTool homepage: https://github.com/bluenote-1577/mylotools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mylotools:2.0.0--pyh7e72e81_0
stdout: mylotools.out
