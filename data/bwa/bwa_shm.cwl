cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - shm
label: bwa_shm
doc: "Manage BWA indices in shared memory\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: idxbase
    type:
      - 'null'
      - string
    doc: The base name of the index to be loaded into shared memory
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
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
stdout: bwa_shm.out
