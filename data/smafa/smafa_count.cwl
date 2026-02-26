cwlVersion: v1.2
class: CommandLineTool
baseCommand: smafa_count
label: smafa_count
doc: "Print the number of reads/bases in a possibly gzipped FASTX file\n\nTool homepage:
  https://github.com/wwood/smafa"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: FASTQ file to count
    inputBinding:
      position: 101
      prefix: --input
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Unless there is an error, do not print logging information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra debug logging information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smafa:0.8.0--hc1c3326_1
stdout: smafa_count.out
