cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yame
  - chunkchar
label: yame_chunkchar
doc: "Chunk a text file into characters.\n\nTool homepage: https://github.com/zhou-lab/YAME"
inputs:
  - id: input_file
    type: File
    doc: Input text file
    inputBinding:
      position: 1
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: chunk size
    inputBinding:
      position: 102
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
stdout: yame_chunkchar.out
