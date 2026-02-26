cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - mapass2maq
label: maq_mapass2maq
doc: "Convert mapass2.map to maq.map format\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: mapass2_map_file
    type: File
    doc: Input mapass2.map file
    inputBinding:
      position: 1
  - id: maq_map_file
    type: File
    doc: Output maq.map file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_mapass2maq.out
