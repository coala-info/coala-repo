cwlVersion: v1.2
class: CommandLineTool
baseCommand: intermine
label: intermine
doc: "The provided text does not contain help information or usage instructions for
  the 'intermine' tool. It contains system log messages and a fatal error regarding
  disk space during a container build process.\n\nTool homepage: http://www.intermine.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intermine:1.13.0--pyh5e36f6f_0
stdout: intermine.out
