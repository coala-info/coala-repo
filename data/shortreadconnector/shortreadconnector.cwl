cwlVersion: v1.2
class: CommandLineTool
baseCommand: shortreadconnector
label: shortreadconnector
doc: "ShortReadConnector is a tool for finding common reads between two sets of sequencing
  data. (Note: The provided text contained container runtime error logs rather than
  tool help text; description and arguments could not be extracted from the input).\n
  \nTool homepage: https://github.com/GATB/short_read_connector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shortreadconnector:1.1.3--0
stdout: shortreadconnector.out
