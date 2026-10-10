cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metaeuk
  - createdb
label: metaeuk_createdb
doc: "Create a MetaEuk (MMseqs2) sequence database from one or more FASTA files.\n\nTool
  homepage: https://github.com/soedinglab/metaeuk"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: fasta_files
    type: 'File[]'
    doc: Input FASTA file(s), optionally gzip or bzip2 compressed
    inputBinding:
      position: 1
  - id: sequence_db_path
    type: string
    doc: Output sequence database name
    inputBinding:
      position: 2
  - id: dbtype
    type: ['null', int]
    doc: 'Database type 0: auto, 1: amino acid 2: nucleotides [0]'
    inputBinding:
      position: 101
      prefix: --dbtype
  - id: shuffle
    type: ['null', int]
    doc: Shuffle input database (0 or 1) [1]
    inputBinding:
      position: 101
      prefix: --shuffle
  - id: createdb_mode
    type: ['null', int]
    doc: 'Createdb mode 0: copy data, 1: soft link data and write new index (works only with
      single line fasta/q) [0]'
    inputBinding:
      position: 101
      prefix: --createdb-mode
  - id: id_offset
    type: ['null', int]
    doc: Numeric ids in index file are offset by this value [0]
    inputBinding:
      position: 101
      prefix: --id-offset
  - id: compressed
    type: ['null', int]
    doc: Write compressed output [0]
    inputBinding:
      position: 101
      prefix: --compressed
  - id: verbosity_level
    type: ['null', int]
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]'
    inputBinding:
      position: 101
      prefix: -v
  - id: write_lookup
    type: ['null', int]
    doc: write .lookup file containing mapping from internal id, fasta id and file number [1]
    inputBinding:
      position: 101
      prefix: --write-lookup
outputs:
  - id: sequence_db
    type: 'File[]'
    doc: All files of the sequence database (data, .index, .dbtype, .lookup, .source, _h, _h.index, _h.dbtype)
    outputBinding:
      glob: "$(inputs.sequence_db_path)*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2
