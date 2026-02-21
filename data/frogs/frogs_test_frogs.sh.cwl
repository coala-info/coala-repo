cwlVersion: v1.2
class: CommandLineTool
baseCommand: frogs_test_frogs.sh
label: frogs_test_frogs.sh
doc: "The provided text does not contain a description of the tool, as it appears
  to be an error log related to a container execution environment rather than help
  text.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: frogs_test_frogs.sh.out
