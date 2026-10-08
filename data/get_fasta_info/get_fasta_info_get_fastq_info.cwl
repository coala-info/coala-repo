cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_fastq_info
label: get_fasta_info_get_fastq_info
doc: "Get basic summary info about fastq formatted files.\n\nTool homepage: https://github.com/nylander/get_fasta_info"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: "Input fastq file(s), gzipped or not."
    inputBinding:
      position: 1
  - id: noverbose
    type:
      - 'null'
      - boolean
    doc: "noverbose"
    inputBinding:
      position: 2
      prefix: -n
  - id: show_avg_quality
    type:
      - 'null'
      - boolean
    doc: "show avg. read qual (ASCII_BASE=33)"
    inputBinding:
      position: 2
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_fasta_info:2.5.0--h577a1d6_0
stdout: get_fasta_info_get_fastq_info.out
