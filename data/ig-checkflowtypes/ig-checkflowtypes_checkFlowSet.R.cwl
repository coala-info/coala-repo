cwlVersion: v1.2
class: CommandLineTool
baseCommand: ig-checkflowtypes_checkFlowSet.R
label: ig-checkflowtypes_checkFlowSet.R
doc: "A tool for checking flow sets. (Note: The provided help text contains system
  error logs and does not list specific command-line arguments.)\n\nTool homepage:
  https://github.com/ImmPortDB/ig-checkflowtypes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ig-checkflowtypes:1.0.0--r351h1606924_1
stdout: ig-checkflowtypes_checkFlowSet.R.out
