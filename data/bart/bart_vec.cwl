cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, vec]
requirements:
  - class: InlineJavascriptRequirement
label: bart_vec
doc: "vec val1 val2 ... valN name\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: val1
    type:
      type: array
      items: string
    doc: val1
    inputBinding:
      position: 10
  - id: name
    type: string
    doc: name
    inputBinding:
      position: 11
outputs:
  - id: name_file
    type: File
    doc: Array written as name.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
