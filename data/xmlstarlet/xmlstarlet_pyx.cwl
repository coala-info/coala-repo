cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xml
  - pyx
label: xmlstarlet_pyx
doc: "Convert XML into PYX format\n\nTool homepage: http://xmlstar.sourceforge.net/"
inputs:
  - id: xml_file
    type: File
    doc: 'Input XML document file (stdin is used if missing).'
    inputBinding:
      position: 1
outputs:
  - id: output
    type: stdout
    doc: Standard output of xml pyx.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmlstarlet:1.6.1
stdout: xmlstarlet_pyx.out
