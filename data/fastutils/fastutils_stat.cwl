cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastutils
  - stat
label: fastutils_stat
doc: "Compute statistics for fasta/q files.\n\nTool homepage: https://github.com/haghshenas/fastutils"
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
  - id: output_file_path
    type: string
    doc: output file [stdout]
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastutils:0.3--h077b44d_5
