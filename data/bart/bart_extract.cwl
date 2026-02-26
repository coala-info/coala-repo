cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_extract
label: bart_extract
doc: "Extracts a sub-array along {dim} from index {start} to (not including) {end}.\n\
  \nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: dimension
    type: string
    doc: The dimension to extract from.
    inputBinding:
      position: 1
  - id: start
    type: int
    doc: The starting index (inclusive).
    inputBinding:
      position: 2
  - id: end
    type: int
    doc: The ending index (exclusive).
    inputBinding:
      position: 3
  - id: input
    type: File
    doc: The input array file.
    inputBinding:
      position: 4
outputs:
  - id: output
    type: File
    doc: The output array file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
