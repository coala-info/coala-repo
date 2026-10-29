cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - convertkb
label: mmseqs2_convertkb
doc: 'Convert UniProtKB flat files (.dat) to a database.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: uniprotkb_dat
    type:
      type: array
      items: File
    doc: UniProtKB flat files (optionally gzip)
    inputBinding:
      position: 1
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output UniProtKB database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: Specify a file that translates the keys of a DB to new keys, TSV format
    inputBinding:
      position: 104
      prefix: --mapping-file
  - id: kb_columns
    type:
      - 'null'
      - string
    doc: list of indices of UniprotKB columns to be extracted
    inputBinding:
      position: 104
      prefix: --kb-columns
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the new database files
    outputBinding:
      glob: out_db
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
