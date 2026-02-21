cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiptv
label: shiptv
doc: "The provided text does not contain help information or usage instructions for
  the tool 'shiptv'. It appears to be a log of a failed container build process due
  to insufficient disk space.\n\nTool homepage: https://github.com/peterk87/shiptv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiptv:0.4.1--pyh5e36f6f_0
stdout: shiptv.out
