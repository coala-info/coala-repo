cwlVersion: v1.2
class: CommandLineTool
baseCommand: hpc-blast
label: hpcblast_hpc-blast
doc: "hpc-blast <OPTIONS> <blast command>\n\nTool homepage: https://github.com/yodeng/hpc-blast"
inputs:
  - id: blast_command
    type:
      type: array
      items: string
    doc: blast command (for example blastn -query q.fa -db db -out result.tsv), required;
      it is placed after all hpc-blast options
    inputBinding:
      position: 200
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: files used by the blast command (query, database files); they are placed
      in the working directory under their own names
  - id: cpu
    type:
      - 'null'
      - int
    doc: cpu usage for sge, 1 by default, max(--cpu, -num_threads) will be used
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
    inputBinding:
      position: 102
      prefix: --split
  - id: tempdir
    type:
      - 'null'
      - string
    doc: hpc blast temp directory
    inputBinding:
      position: 102
      prefix: --tempdir
  - id: log_path
    type:
      - 'null'
      - string
    doc: append hpc-blast log info to file, sys.stdout by default
    inputBinding:
      position: 103
      prefix: --log
  - id: blast_output
    type:
      - 'null'
      - string
    doc: name of the result file written by the blast command (its -out file)
outputs:
  - id: log
    type:
      - 'null'
      - File
    doc: append hpc-blast log info to file, sys.stdout by default
    outputBinding:
      glob: $(inputs.log_path)
  - id: blast_result
    type:
      - 'null'
      - File
    doc: result file written by the blast command
    outputBinding:
      glob: $(inputs.blast_output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hpcblast:1.0.2--pyhdfd78af_0
