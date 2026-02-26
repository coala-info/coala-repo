cwlVersion: v1.2
class: CommandLineTool
baseCommand: ig-checkflowtypes_checkFlowSet.R
label: ig-checkflowtypes_checkFlowSet.R
doc: "Checks flowSet objects for validity and readability.\n\nTool homepage: https://github.com/ImmPortDB/ig-checkflowtypes"
inputs:
  - id: input_file
    type: File
    doc: The flowSet object to check.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ig-checkflowtypes:1.0.0--r351h1606924_1
stdout: ig-checkflowtypes_checkFlowSet.R.out
