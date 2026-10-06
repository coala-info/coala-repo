cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, extract]
requirements:
  - class: InlineJavascriptRequirement
label: bart_extract
doc: "Extracts a sub-array along {dim} from index {start} to (not including) {end}.\n\
  \nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: dimension
    type: string
    doc: The dimension to extract from.
    inputBinding:
      position: 10
  - id: start
    type: int
    doc: The starting index (inclusive).
    inputBinding:
      position: 11
  - id: end
    type: int
    doc: The ending index (exclusive).
    inputBinding:
      position: 12
  - id: input
    type: File
    doc: The input array file.
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 13
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 14
outputs:
  - id: output
    type: File
    doc: The output array file.
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
