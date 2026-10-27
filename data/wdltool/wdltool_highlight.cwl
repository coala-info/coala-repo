cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wdltool
  - highlight
label: wdltool_highlight
doc: "Reformats and colorizes/tags a WDL file. The output type is html (span tags around elements) or console (colorized terminal text).\n\nTool homepage: https://github.com/broadinstitute/wdltool"
inputs:
  - id: wdl_file
    type: File
    doc: WDL file
    inputBinding:
      position: 1
  - id: output_type
    type: string
    doc: Output type, html or console
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wdltool:0.14--1
stdout: wdltool_highlight.out
