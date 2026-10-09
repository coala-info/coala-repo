cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkFCS.R
label: ig-checkflowtypes_checkFCS.R
doc: "Checks whether a file is a valid FCS (flow cytometry standard) file (prints TRUE, or an error message).\n\nTool homepage: https://github.com/ImmPortDB/ig-checkflowtypes"
inputs:
  - id: input_file
    type: File
    doc: The file to check (FCS format).
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (TRUE when the file is valid)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ig-checkflowtypes:1.0.0--r351h1606924_1
stdout: ig-checkflowtypes_checkFCS.R.out
