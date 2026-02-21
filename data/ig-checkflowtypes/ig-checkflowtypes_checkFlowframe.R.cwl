cwlVersion: v1.2
class: CommandLineTool
baseCommand: ig-checkflowtypes_checkFlowframe.R
label: ig-checkflowtypes_checkFlowframe.R
doc: "A tool to check flow frame types. (Note: The provided input text appears to
  be a system error log regarding container execution rather than the tool's help
  documentation.)\n\nTool homepage: https://github.com/ImmPortDB/ig-checkflowtypes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ig-checkflowtypes:1.0.0--r351h1606924_1
stdout: ig-checkflowtypes_checkFlowframe.R.out
