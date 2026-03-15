cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - makedb
label: diamond_makedb
doc: Build a DIAMOND database from a FASTA file
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: db
    type: string
    doc: database file
    inputBinding:
      position: 101
      prefix: --db
  - id: in
    type:
      - 'null'
      - File
    doc: input reference file in FASTA format/input DAA files for merge-daa
    inputBinding:
      position: 101
      prefix: --in
  - id: taxonmap
    type:
      - 'null'
      - File
    doc: protein accession to taxid mapping file
    inputBinding:
      position: 101
      prefix: --taxonmap
  - id: taxonnodes
    type:
      - 'null'
      - File
    doc: taxonomy nodes.dmp from NCBI
    inputBinding:
      position: 101
      prefix: --taxonnodes
  - id: taxonnames
    type:
      - 'null'
      - File
    doc: taxonomy names.dmp from NCBI
    inputBinding:
      position: 101
      prefix: --taxonnames
  - id: file_buffer_size
    type:
      - 'null'
      - int
    doc: file buffer size in bytes
    inputBinding:
      position: 101
      prefix: --file-buffer-size
  - id: no_unlink
    type:
      - 'null'
      - boolean
    doc: Do not unlink temporary files.
    inputBinding:
      position: 101
      prefix: --no-unlink
  - id: ignore_warnings
    type:
      - 'null'
      - boolean
    doc: Ignore warnings
    inputBinding:
      position: 101
      prefix: --ignore-warnings
  - id: no_parse_seqids
    type:
      - 'null'
      - boolean
    doc: Print raw seqids without parsing
    inputBinding:
      position: 101
      prefix: --no-parse-seqids
outputs:
  - id: output_db
    type: File
    doc: database file
    outputBinding:
      glob: $(inputs.db)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
s:url: https://github.com/bbuchfink/diamond
$namespaces:
  s: https://schema.org/
