cwlVersion: v1.2
class: CommandLineTool
baseCommand: rrparser
label: rrparser
doc: "The provided text is a container build error log and does not contain help documentation
  or usage instructions for the tool 'rrparser'. As a result, no arguments could be
  extracted.\n\nTool homepage: https://github.com/brsynth/RRParser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rrparser:2.7.0
stdout: rrparser.out
