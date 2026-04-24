cwlVersion: v1.2
class: CommandLineTool
baseCommand: unmerge
label: unmerge
doc: "Interlaced forward and reverse paired-end reads to forward and reverse files\n\
  \nTool homepage: https://github.com/andvides/unmerge.git"
inputs:
  - id: file
    type: File
    doc: fastq file
    inputBinding:
      position: 1
  - id: header
    type: string
    doc: read name
    inputBinding:
      position: 2
  - id: num_reads
    type:
      - 'null'
      - int
    doc: extract only n reads
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unmerge:1.0--h503566f_5
stdout: unmerge.out
