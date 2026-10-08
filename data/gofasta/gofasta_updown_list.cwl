cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gofasta
  - updown
  - list
label: gofasta_updown_list
doc: "Generate input CSV files for gofasta updown topranking

Tool homepage: https://github.com/virus-evolution/gofasta"
inputs:
  - id: reference
    type: File
    doc: "Reference sequence, in fasta format, which is treated as the root of the imaginary tree"
    inputBinding:
      position: 101
      prefix: --reference
  - id: query
    type:
      - 'null'
      - File
    doc: "Alignment of sequences to parse, in fasta format (default stdin)"
    inputBinding:
      position: 101
      prefix: --query
  - id: outfile_path
    type:
      - 'null'
      - string
    doc: "Output to write (default stdout)"
    inputBinding:
      position: 102
      prefix: --outfile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outfile
    type:
      - 'null'
      - File
    doc: "Output file"
    outputBinding:
      glob: "$(inputs.outfile_path ? inputs.outfile_path : 'no_outfile')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
stdout: gofasta_updown_list.out
