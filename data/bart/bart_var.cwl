cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, var]
requirements:
  - class: InlineJavascriptRequirement
label: bart_var
doc: "Compute variance along selected dimensions specified by the {bitmask}\n\nTool
  homepage: https://github.com/mrirecon/bart"
inputs:
  - id: bitmask
    type: string
    doc: bitmask specifying dimensions
    inputBinding:
      position: 10
  - id: input
    type: File
    doc: input file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 12
outputs:
  - id: output
    type: File
    doc: output file
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
