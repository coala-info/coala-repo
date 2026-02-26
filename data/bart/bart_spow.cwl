cwlVersion: v1.2
class: CommandLineTool
baseCommand: spow
label: bart_spow
doc: "Raise array to the power of {exponent}. The exponent can be a complex number.\n\
  \nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: exponent
    type: string
    doc: The exponent
    inputBinding:
      position: 1
  - id: input
    type: string
    doc: Input array
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: Output array
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_spow.out
