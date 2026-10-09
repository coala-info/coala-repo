cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - mapstat
label: maq_mapstat
doc: "Statistics about a .map file\n\nTool homepage: http://maq.sourceforge.net/"
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
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_mapstat.out
