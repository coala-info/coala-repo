cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - suffixid
label: mmseqs2_suffixid
doc: 'For each entry of a database, append the entry key to the entry itself.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: input_db
    type: Directory
    doc: Input database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.input_db_name)
  - id: input_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: prefix
    type:
      - 'null'
      - string
    doc: Use this prefix for all entries
    inputBinding:
      position: 104
      prefix: --prefix
  - id: mapping_file
    type:
      - 'null'
      - string
    doc: Specify a file that translates the keys of a DB to new keys, TSV format
    inputBinding:
      position: 104
      prefix: --mapping-file
  - id: tsv
    type:
      - 'null'
      - int
    doc: Return output in TSV format (0 or 1)
    inputBinding:
      position: 104
      prefix: --tsv
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
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
    doc: Directory holding the output database files
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
