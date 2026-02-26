cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastutils_stat
label: fastutils_stat
doc: "Compute statistics for fasta/q files.\n\nTool homepage: https://github.com/haghshenas/fastutils"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file in fasta/q format
    default: stdin
    inputBinding:
      position: 101
      prefix: --in
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: max read length
    default: INT64_MAX
    inputBinding:
      position: 101
      prefix: --maxLen
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: min read length
    default: 0
    inputBinding:
      position: 101
      prefix: --minLen
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
