cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta_stats
label: fastaindex_fasta_stats
doc: "Report FASTA statistics. Support gzipped files.\n\nTool homepage: https://github.com/lpryszcz/FastaIndex"
inputs:
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA file(s)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_stream_path
    type: string
    doc: Output or path parameter `output_stream_path`
    inputBinding:
      position: 102
      prefix: --output-stream
outputs:
  - id: output_stream
    type:
      - 'null'
      - File
    doc: output stream
    outputBinding:
      glob: $(inputs.output_stream_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaindex:0.11c--py36_0
