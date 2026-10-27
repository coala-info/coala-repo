cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wdltool
  - inputs
label: wdltool_inputs
doc: "Print a JSON skeleton file of the inputs needed for this workflow.\n\nTool homepage: https://github.com/broadinstitute/wdltool"
inputs:
  - id: wdl_file
    type: File
    doc: WDL file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wdltool:0.14--1
stdout: wdltool_inputs.out
