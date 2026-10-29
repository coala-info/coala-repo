cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - setextendeddbtype
label: mmseqs2_setextendeddbtype
doc: 'Write an extended database type into a database (.dbtype file).


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: db_to_change
    type: Directory
    doc: Database whose type is changed (the change is done in a writable copy; the input
      is not changed)
    inputBinding:
      position: 1
      valueFrom: db_dir/$(inputs.db_to_change_name)
  - id: db_to_change_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: extended_dbtype
    type:
      - 'null'
      - int
    doc: 'Set extended dbtype 1: compressed, 2: need src, 4: context pseudoe cnts'
    inputBinding:
      position: 104
      prefix: --extended-dbtype
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
    doc: Copy of the input database directory after the change
    outputBinding:
      glob: db_dir
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: db_dir
        entry: $(inputs.db_to_change)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
