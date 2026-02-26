cwlVersion: v1.2
class: CommandLineTool
baseCommand: join
label: bart_join
doc: "Join input files along {dimensions}. All other dimensions must have the same
  size.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: dimension
    type: int
    doc: The dimension to join along
    inputBinding:
      position: 1
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files to join
    inputBinding:
      position: 2
  - id: append
    type:
      - 'null'
      - boolean
    doc: Append - only works for cfl files!
    inputBinding:
      position: 103
      prefix: -a
outputs:
  - id: output_file
    type: File
    doc: Output file name
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
