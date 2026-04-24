cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastutils length
label: fastutils_length
doc: "Calculates length statistics for sequences in FASTA/FASTQ files.\n\nTool homepage:
  https://github.com/haghshenas/fastutils"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file in fasta/q format
    inputBinding:
      position: 101
      prefix: --in
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
  - id: print_total_bases
    type:
      - 'null'
      - boolean
    doc: print total number of bases in third column
    inputBinding:
      position: 101
      prefix: --total
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
