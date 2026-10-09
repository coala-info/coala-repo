cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - mapvalidate
label: maq_mapvalidate
doc: "Validate a .map file\n\nTool homepage: http://maq.sourceforge.net/"
inputs:
  - id: input_map
    type: File
    doc: Input .map file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (messages)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_mapvalidate.out
stderr: maq_mapvalidate.err
