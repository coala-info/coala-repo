cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - lndb
label: mmseqs2_lndb
doc: 'Symlink a DB.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: src_db
    type: Directory
    doc: Source database directory (a writable copy is used; the input is not changed)
    inputBinding:
      position: 1
      valueFrom: src_dir/$(inputs.src_db_name)
  - id: src_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: dst_db_name
    type: string
    doc: Name (prefix) of the destination database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
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
    doc: Directory holding the linked database
    outputBinding:
      glob: out_db
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
      - entryname: src_dir
        entry: $(inputs.src_db)
        writable: true
arguments:
  - position: 200
    shellQuote: false
    valueFrom: '&& for l in out_db/*; do if [ -L "$l" ]; then t=`readlink -f "$l"`; rm "$l";
      cp -r "$t" "$l"; fi; done'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
