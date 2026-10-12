cwlVersion: v1.2
class: CommandLineTool
baseCommand: pg_build_sdb
label: peregrine-2021_pg_build_sdb
doc: "Build the sequence database from the reads (Peregrine-2021 assembler stage).\n\nTool homepage: https://github.com/cschin/peregrine-2021"
inputs:
  - id: input
    type: File
    doc: Path to a file that contains the list of reads in .fa .fa.gz .fastq or fastq.gz formats
    inputBinding:
      position: 110
      prefix: --input
  - id: read_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Read files named in the list file; they are staged in the working directory so those names resolve.
  - id: out_prefix
    type: string
    doc: The prefix for the sequence database and index files
    inputBinding:
      position: 110
      prefix: --out_prefix
  - id: log
    type:
      - 'null'
      - string
    doc: "log level: DBBUG or INFO (default)"
    inputBinding:
      position: 110
      prefix: --log
outputs:
  - id: seqdb
    type: File
    doc: Sequence database
    outputBinding:
      glob: $(inputs.out_prefix).seqdb
  - id: seqidx
    type: File
    doc: Sequence database index
    outputBinding:
      glob: $(inputs.out_prefix).idx
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.read_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
