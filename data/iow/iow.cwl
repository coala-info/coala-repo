cwlVersion: v1.2
class: CommandLineTool
baseCommand: iow
label: iow
doc: "The provided text does not contain help information or usage instructions for
  the tool 'iow'. It consists of system log messages and a fatal error regarding disk
  space during a container image pull.\n\nTool homepage: https://github.com/biocore/improved-octo-waddle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iow:1.0.8--py310h1fe012e_1
stdout: iow.out
