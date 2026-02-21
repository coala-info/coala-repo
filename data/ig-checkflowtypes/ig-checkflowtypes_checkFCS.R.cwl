cwlVersion: v1.2
class: CommandLineTool
baseCommand: ig-checkflowtypes_checkFCS.R
label: ig-checkflowtypes_checkFCS.R
doc: "A tool for checking flow types in FCS files. (Note: The provided text is an
  execution error log and does not contain usage or argument information.)\n\nTool
  homepage: https://github.com/ImmPortDB/ig-checkflowtypes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ig-checkflowtypes:1.0.0--r351h1606924_1
stdout: ig-checkflowtypes_checkFCS.R.out
