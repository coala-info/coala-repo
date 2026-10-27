cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wdltool
  - validate
label: wdltool_validate
doc: "Performs full validation of the WDL file including syntax and semantic checking.\n\nTool homepage: https://github.com/broadinstitute/wdltool"
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
stdout: wdltool_validate.out
