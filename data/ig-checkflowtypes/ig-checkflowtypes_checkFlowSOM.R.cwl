cwlVersion: v1.2
class: CommandLineTool
baseCommand: ig-checkflowtypes_checkFlowSOM.R
label: ig-checkflowtypes_checkFlowSOM.R
doc: "Check FlowSOM types. (Note: The provided text contains container runtime error
  messages and does not include usage instructions or argument definitions).\n\nTool
  homepage: https://github.com/ImmPortDB/ig-checkflowtypes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ig-checkflowtypes:1.0.0--r351h1606924_1
stdout: ig-checkflowtypes_checkFlowSOM.R.out
