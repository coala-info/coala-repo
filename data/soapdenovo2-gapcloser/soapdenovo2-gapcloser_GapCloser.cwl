cwlVersion: v1.2
class: CommandLineTool
baseCommand: GapCloser
label: soapdenovo2-gapcloser_GapCloser
doc: GapCloser is a tool for closing gaps in assembled sequences.
inputs:
  - id: input_library_info_file
    type: string
    doc: input library info file name
    inputBinding:
      position: 101
      prefix: -b
  - id: input_scaffold_file
    type: string
    doc: input scaffold file name
    inputBinding:
      position: 101
      prefix: -a
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: maximum read length (<=155)
    default: 100
    inputBinding:
      position: 101
      prefix: -l
  - id: output_file
    type: string
    doc: output file name
    inputBinding:
      position: 101
      prefix: -o
  - id: overlap_param
    type:
      - 'null'
      - int
    doc: overlap param(<=31)
    default: 25
    inputBinding:
      position: 101
      prefix: -p
  - id: thread_number
    type:
      - 'null'
      - int
    doc: thread number
    default: 1
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapdenovo2-gapcloser:1.12--h077b44d_3
stdout: soapdenovo2-gapcloser_GapCloser.out
