cwlVersion: v1.2
class: CommandLineTool
baseCommand: invert
label: bart_invert
doc: "Invert array (1 / <input>). The output is set to zero in case of divide by zero.\n\
  \nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: string
    doc: Input array
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: Output array
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_invert.out
