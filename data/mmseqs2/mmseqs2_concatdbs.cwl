cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - concatdbs
label: mmseqs2_concatdbs
doc: 'Concatenate two databases, giving new keys to the entries of the second one.


  By Clovis Galiez, Eli Levy Karin & Martin Steinegger (martin.steinegger@snu.ac.kr)


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: first_db
    type: Directory
    doc: First database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.first_db_name)
  - id: first_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: second_db
    type: Directory
    doc: Second database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.second_db_name)
  - id: second_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 3
      valueFrom: out_db/$(self)
  - id: preserve_keys
    type:
      - 'null'
      - int
    doc: The keys of the two DB should be distinct, and they will be preserved in the concatenation
      (0 or 1)
    inputBinding:
      position: 104
      prefix: --preserve-keys
  - id: take_larger_entry
    type:
      - 'null'
      - int
    doc: Only keep the larger entry (dataSize >) in the concatenation, both databases need
      the same keys in the index (0 or 1)
    inputBinding:
      position: 104
      prefix: --take-larger-entry
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
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
