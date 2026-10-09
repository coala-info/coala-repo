cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkFlowSet.R
label: ig-checkflowtypes_checkFlowSet.R
doc: "Checks whether an RDS file holds a valid flowSet object (prints TRUE, or an error message).\n\nTool homepage: https://github.com/ImmPortDB/ig-checkflowtypes"
inputs:
  - id: input_file
    type: File
    doc: The RDS file to check (flowCore flowSet object).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (TRUE when the file is valid)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ig-checkflowtypes:1.0.0--r351h1606924_1
stdout: ig-checkflowtypes_checkFlowSet.R.out
