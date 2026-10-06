cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, rss]
requirements:
  - class: InlineJavascriptRequirement
label: bart_rss
doc: "Calculates root of sum of squares along selected dimensions.\n\nTool homepage:
  https://github.com/mrirecon/bart"
inputs:
  - id: bitmask
    type: string
    doc: bitmask
    inputBinding:
      position: 10
  - id: input
    type: File
    doc: input
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 12
outputs:
  - id: output_file
    type: File
    doc: Array written as output.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
