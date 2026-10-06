cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, slice]
requirements:
  - class: InlineJavascriptRequirement
label: bart_slice
doc: "Extracts a slice from {position} along {dimension}.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: dimension
    type: string
    doc: The dimension along which to slice.
    inputBinding:
      position: 10
  - id: position
    type: int
    doc: The position along the specified dimension to slice at.
    inputBinding:
      position: 11
  - id: input
    type: File
    doc: Input file.
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 12
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 13
outputs:
  - id: output
    type: File
    doc: Output file.
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
