cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - makedb
label: diamond_makedb
doc: "Build a DIAMOND database from a FASTA file\n\nTool homepage: https://github.com/bbuchfink/diamond"
inputs:
  - id: file_buffer_size
    type:
      - 'null'
      - int
    doc: file buffer size in bytes
    default: 67108864
    inputBinding:
      position: 101
      prefix: --file-buffer-size
  - id: ignore_warnings
    type:
      - 'null'
      - boolean
    doc: Ignore warnings
    inputBinding:
      position: 101
      prefix: --ignore-warnings
  - id: in
    type:
      - 'null'
      - File
    doc: input reference file in FASTA format/input DAA files for merge-daa
    inputBinding:
      position: 101
      prefix: --in
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: no_parse_seqids
    type:
      - 'null'
      - boolean
    doc: Print raw seqids without parsing
    inputBinding:
      position: 101
      prefix: --no-parse-seqids
  - id: no_unlink
    type:
      - 'null'
      - boolean
    doc: Do not unlink temporary files.
    inputBinding:
      position: 101
      prefix: --no-unlink
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: taxonmap
    type:
      - 'null'
      - File
    doc: protein accession to taxid mapping file
    inputBinding:
      position: 101
      prefix: --taxonmap
  - id: taxonnames
    type:
      - 'null'
      - File
    doc: taxonomy names.dmp from NCBI
    inputBinding:
      position: 101
      prefix: --taxonnames
  - id: taxonnodes
    type:
      - 'null'
      - File
    doc: taxonomy nodes.dmp from NCBI
    inputBinding:
      position: 101
      prefix: --taxonnodes
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose console output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: db
    type:
      - 'null'
      - File
    doc: database file
    outputBinding:
      glob: $(inputs.db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
