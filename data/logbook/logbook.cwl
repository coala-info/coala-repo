cwlVersion: v1.2
class: CommandLineTool
baseCommand: logbook
label: logbook
doc: "The provided text does not contain help information or usage instructions for
  the 'logbook' tool. It contains system log messages and a fatal error regarding
  container image conversion (no space left on device).\n\nTool homepage: http://logbook.pocoo.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/logbook:1.4.3--py27h14c3975_0
stdout: logbook.out
