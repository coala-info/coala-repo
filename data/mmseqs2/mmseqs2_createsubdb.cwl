cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - createsubdb
label: mmseqs2_createsubdb
doc: 'Create a subset of a database from a list of keys or from the keys of another database.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: subset_file
    type:
      - 'null'
      - File
    doc: Text file with one database key per line (use this or subset_db)
    inputBinding:
      position: 1
  - id: subset_db
    type:
      - 'null'
      - Directory
    doc: Database whose keys select the entries (use this or subset_file)
    inputBinding:
      position: 1
      valueFrom: '$(self === null ? null : self.path + "/" + inputs.subset_db_name)'
  - id: subset_db_name
    type:
      - 'null'
      - string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: input_db
    type: Directory
    doc: Database to take the entries from
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
  - id: id_mode
    type:
      - 'null'
      - int
    doc: 'Select DB entries based on 0: database keys, 1: FASTA identifiers (.lookup)'
    inputBinding:
      position: 104
      prefix: --id-mode
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
arguments:
  - position: 200
    shellQuote: false
    valueFrom: '&& for f in out_db/*; do if [ -L "$f" ]; then t=`readlink -f "$f"`; rm "$f";
      cp "$t" "$f"; fi; done'
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
