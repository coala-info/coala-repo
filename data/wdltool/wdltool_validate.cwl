cwlVersion: v1.2
class: CommandLineTool
baseCommand: wdltool
label: wdltool_validate
doc: "Validates a WDL file.\n\nTool homepage: https://github.com/broadinstitute/wdltool"
inputs:
  - id: wdl_file
    type: File
    doc: The WDL file to validate.
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
