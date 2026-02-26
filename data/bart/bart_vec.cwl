cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_vec
label: bart_vec
doc: "vec val1 val2 ... valN name\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: val1
    type:
      type: array
      items: string
    doc: val1
    inputBinding:
      position: 1
  - id: name
    type: string
    doc: name
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_vec.out
