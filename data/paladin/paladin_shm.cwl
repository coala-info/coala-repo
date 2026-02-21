cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - shm
label: paladin_shm
doc: "Manage indices in shared memory\n\nTool homepage: https://github.com/ToniWestbrook/paladin"
inputs:
  - id: idxbase
    type:
      - 'null'
      - string
    doc: Index base name
    inputBinding:
      position: 1
  - id: destroy
    type:
      - 'null'
      - boolean
    doc: destroy all indices in shared memory
    inputBinding:
      position: 102
      prefix: -d
  - id: list
    type:
      - 'null'
      - boolean
    doc: list names of indices in shared memory
    inputBinding:
      position: 102
      prefix: -l
  - id: tmp_file
    type:
      - 'null'
      - File
    doc: temporary file to reduce peak memory
    inputBinding:
      position: 102
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
stdout: paladin_shm.out
