cwlVersion: v1.2
class: CommandLineTool
baseCommand: pg_layout
label: peregrine-2021_pg_layout
doc: "Convert the assembly graph to paths and generate the contig fasta file (Peregrine-2021 assembler stage).\n\nTool homepage: https://github.com/cschin/peregrine-2021"
inputs:
  - id: seqdb
    type: File
    doc: Path to the seqdb file
    inputBinding:
      position: 200
  - id: seqidx
    type: File
    doc: Path to the seqdb index file
    inputBinding:
      position: 201
  - id: layout_file
    type: File
    doc: Path to the layout file
    inputBinding:
      position: 110
      prefix: --layout_file
  - id: output_path
    type: string
    doc: Path to the output file
    inputBinding:
      position: 110
      prefix: --output
  - id: log
    type:
      - 'null'
      - string
    doc: "log level: DBBUG or INFO (default)"
    inputBinding:
      position: 110
      prefix: --log
outputs:
  - id: contigs
    type:
      type: array
      items: File
    doc: Contig fasta files (the output name with _m.fa and _e0.fa suffixes)
    outputBinding:
      glob: $(inputs.output_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
