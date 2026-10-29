cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - renamedbkeys
label: mmseqs2_renamedbkeys
doc: 'Create a new database with the keys of the entries renamed according to an ID map file.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: id_map_file
    type: File
    doc: 'Tab-separated ID map file: old key, new key'
    inputBinding:
      position: 1
  - id: input_db
    type: Directory
    doc: Input database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.input_db_name)
  - id: input_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 3
      valueFrom: out_db/$(self)
  - id: subdb_mode
    type:
      - 'null'
      - int
    doc: 'Subdb mode 0: copy data 1: soft link data and write index'
    inputBinding:
      position: 104
      prefix: --subdb-mode
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
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
  - class: ShellCommandRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
arguments:
  - shellQuote: false
    position: 1000
    valueFrom: '&& cp -rL out_db out_db_tmp && rm -rf out_db && mv out_db_tmp out_db'
