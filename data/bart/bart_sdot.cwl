cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, sdot]
requirements:
  - class: InlineJavascriptRequirement
label: bart_sdot
doc: "Compute dot product along selected dimensions.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: input1
    type: File
    doc: First input
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: input2
    type: File
    doc: Second input
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_sdot.out
