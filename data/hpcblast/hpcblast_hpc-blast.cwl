cwlVersion: v1.2
class: CommandLineTool
baseCommand: hpc-blast
label: hpcblast_hpc-blast
doc: "hpc-blast <OPTIONS> <blast command>\n\nTool homepage: https://github.com/yodeng/hpc-blast"
inputs:
  - id: blast_command
    type: string
    doc: blast command, required
    inputBinding:
      position: 1
  - id: cpu
    type:
      - 'null'
      - int
    doc: cpu usage for sge, 1 by default, max(--cpu, -num_threads) will be used
    default: 1
    inputBinding:
      position: 102
      prefix: --cpu
  - id: local
    type:
      - 'null'
      - boolean
    doc: run blast in localhost instead of sge
    inputBinding:
      position: 102
      prefix: --local
  - id: memory
    type:
      - 'null'
      - int
    doc: memory (GB) usage for sge, 1 by default
    default: 1
    inputBinding:
      position: 102
      prefix: --memory
  - id: num
    type:
      - 'null'
      - int
    doc: max number of chunks run parallelly, all chunks by default
    inputBinding:
      position: 102
      prefix: --num
  - id: queue
    type:
      - 'null'
      - type: array
        items: string
    doc: sge queue, multi-queue can be sepreated by whitespace, all access queue
      by default
    inputBinding:
      position: 102
      prefix: --queue
  - id: size
    type:
      - 'null'
      - int
    doc: split query into multi chunks with N sequences
    inputBinding:
      position: 102
      prefix: --size
  - id: split
    type:
      - 'null'
      - int
    doc: split query into num of chunks, 10 by default
    default: 10
    inputBinding:
      position: 102
      prefix: --split
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: hpc blast temp directory
    inputBinding:
      position: 102
      prefix: --tempdir
outputs:
  - id: log
    type:
      - 'null'
      - File
    doc: append hpc-blast log info to file, sys.stdout by default
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hpcblast:1.0.2--pyhdfd78af_0
