cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - fastmap
label: bwa_fastmap
doc: "Identify Super Maximal Exact Matches (SMEMs) in a sequence against a reference
  index.\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: idxbase
    type: string
    doc: The prefix of the BWA index files
    inputBinding:
      position: 1
  - id: input_fastq
    type: File
    doc: Input FASTQ file
    inputBinding:
      position: 2
  - id: max_interval_size
    type:
      - 'null'
      - int
    doc: max interval size to find coordinates
    inputBinding:
      position: 103
      prefix: -w
  - id: max_mem_length
    type:
      - 'null'
      - int
    doc: max MEM length
    inputBinding:
      position: 103
      prefix: -L
  - id: min_smem_interval_size
    type:
      - 'null'
      - int
    doc: min SMEM interval size
    inputBinding:
      position: 103
      prefix: -i
  - id: min_smem_length
    type:
      - 'null'
      - int
    doc: min SMEM length to output
    inputBinding:
      position: 103
      prefix: -l
  - id: stop_mem_threshold
    type:
      - 'null'
      - int
    doc: stop if MEM is longer than -l with a size less than INT
    inputBinding:
      position: 103
      prefix: -I
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
stdout: bwa_fastmap.out
