cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xml
  - p2x
label: xmlstarlet_p2x
doc: "Convert PYX into XML\n\nTool homepage: http://xmlstar.sourceforge.net/"
inputs:
  - id: pyx_file
    type: File
    doc: 'Input PYX document file (stdin is used if missing).'
    inputBinding:
      position: 1
outputs:
  - id: output
    type: stdout
    doc: Standard output of xml p2x.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xmlstarlet:1.6.1
stdout: xmlstarlet_p2x.out
