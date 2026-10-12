cwlVersion: v1.2
class: CommandLineTool
baseCommand: pg_getreads
label: peregrine-2021_pg_getreads
doc: "Generate a fasta file for a subset of reads from the sequence database (Peregrine-2021 assembler stage).\n\nTool homepage: https://github.com/cschin/peregrine-2021"
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
  - id: read_id_file
    type: File
    doc: Path to the read id file
    inputBinding:
      position: 202
  - id: log
    type:
      - 'null'
      - string
    doc: "log level: DBBUG or INFO (default)"
    inputBinding:
      position: 110
      prefix: --log
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
stdout: peregrine-2021_pg_getreads.fa
