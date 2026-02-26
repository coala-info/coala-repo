cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yame
  - chunk
label: yame_chunk
doc: "Chunk a .cx file into smaller pieces.\n\nTool homepage: https://github.com/zhou-lab/YAME"
inputs:
  - id: input_cx_file
    type: File
    doc: Input .cx file
    inputBinding:
      position: 1
  - id: output_directory
    type: Directory
    doc: Output directory for chunks
    inputBinding:
      position: 2
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: chunk size
    inputBinding:
      position: 103
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yame:1.8--ha83d96e_0
stdout: yame_chunk.out
