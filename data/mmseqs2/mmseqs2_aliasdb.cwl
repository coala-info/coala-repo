cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - aliasdb
label: mmseqs2_aliasdb
doc: 'Create a relative symbolic link of a database under another name in the same folder.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: src_db
    type: Directory
    doc: Source database (linked inside a writable copy of this directory)
    inputBinding:
      position: 1
      valueFrom: db_dir/$(inputs.src_db_name)
  - id: src_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: alias_name
    type: string
    doc: New name of the alias, created next to the source database
    inputBinding:
      position: 2
      valueFrom: db_dir/$(self)
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
    doc: Database directory with the new alias
    outputBinding:
      glob: db_dir
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: db_dir
        entry: $(inputs.src_db)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
