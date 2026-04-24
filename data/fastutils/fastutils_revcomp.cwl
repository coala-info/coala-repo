cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastutils_revcomp
label: fastutils_revcomp
doc: "Reverse complement sequences in FASTA/Q format.\n\nTool homepage: https://github.com/haghshenas/fastutils"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file in fasta/q format
    inputBinding:
      position: 101
      prefix: --in
  - id: lexicographically_smaller
    type:
      - 'null'
      - boolean
    doc: output lexicographically smaller sequence
    inputBinding:
      position: 101
      prefix: --lex
  - id: line_width
    type:
      - 'null'
      - int
    doc: size of lines in fasta output. Use 0 for no wrapping
    inputBinding:
      position: 101
      prefix: --lineWidth
  - id: output_fastq
    type:
      - 'null'
      - boolean
    doc: output reads in fastq format if possible
    inputBinding:
      position: 101
      prefix: --fastq
  - id: print_comments
    type:
      - 'null'
      - boolean
    doc: print comments in headers
    inputBinding:
      position: 101
      prefix: --comment
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastutils:0.3--h077b44d_5
