cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - shm
label: bwa-aln-interactive_shm
doc: "Manage BWA indices in shared memory\n\nTool homepage: https://github.com/fulcrumgenomics/bwa-aln-interactive"
inputs:
  - id: idxbase
    type:
      - 'null'
      - string
    doc: Index base name
    inputBinding:
      position: 1
  - id: destroy_indices
    type:
      - 'null'
      - boolean
    doc: destroy all indices in shared memory
    inputBinding:
      position: 102
      prefix: -d
  - id: list_indices
    type:
      - 'null'
      - boolean
    doc: list names of indices in shared memory
    inputBinding:
      position: 102
      prefix: -l
  - id: temp_file
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
    dockerPull: quay.io/biocontainers/bwa-aln-interactive:0.7.18--h577a1d6_2
stdout: bwa-aln-interactive_shm.out
