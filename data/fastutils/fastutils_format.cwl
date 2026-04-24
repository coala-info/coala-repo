cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastutils_format
label: fastutils_format
doc: "Format FASTA/FASTQ files\n\nTool homepage: https://github.com/haghshenas/fastutils"
inputs:
  - id: digital_read_name
    type:
      - 'null'
      - boolean
    doc: use read index instead as read name
    inputBinding:
      position: 101
      prefix: --digital
  - id: fastq_output
    type:
      - 'null'
      - boolean
    doc: output reads in fastq format if possible
    inputBinding:
      position: 101
      prefix: --fastq
  - id: file_of_file_names
    type:
      - 'null'
      - boolean
    doc: input file is a file of file names
    inputBinding:
      position: 101
      prefix: --fofn
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file in fasta/q format
    inputBinding:
      position: 101
      prefix: --in
  - id: keep_name_as_comment
    type:
      - 'null'
      - boolean
    doc: keep name as a comment when using -d
    inputBinding:
      position: 101
      prefix: --keep
  - id: line_width
    type:
      - 'null'
      - int
    doc: size of lines in fasta output. Use 0 for no wrapping
    inputBinding:
      position: 101
      prefix: --lineWidth
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: max read length
    inputBinding:
      position: 101
      prefix: --maxLen
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: min read length
    inputBinding:
      position: 101
      prefix: --minLen
  - id: no_n
    type:
      - 'null'
      - boolean
    doc: do not print entries with N's
    inputBinding:
      position: 101
      prefix: --noN
  - id: pacbio_header
    type:
      - 'null'
      - boolean
    doc: use pacbio's header format
    inputBinding:
      position: 101
      prefix: --pacbio
  - id: prefix
    type:
      - 'null'
      - string
    doc: prepend STR to the name
    inputBinding:
      position: 101
      prefix: --prefix
  - id: print_comments
    type:
      - 'null'
      - boolean
    doc: print comments in headers
    inputBinding:
      position: 101
      prefix: --comment
  - id: suffix
    type:
      - 'null'
      - string
    doc: append STR to the name
    inputBinding:
      position: 101
      prefix: --suffix
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
