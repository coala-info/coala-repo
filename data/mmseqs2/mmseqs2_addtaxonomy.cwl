cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - addtaxonomy
label: mmseqs2_addtaxonomy
doc: 'Add taxonomic labels (from the target database) to a result database.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: target_db
    type: Directory
    doc: Target database that carries taxonomy (made with createtaxdb)
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.target_db_name)
  - id: target_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: result_db
    type: Directory
    doc: Result database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.result_db_name)
  - id: result_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_result_db_name
    type: string
    doc: Name (prefix) of the output result database, written inside the output directory
    inputBinding:
      position: 3
      valueFrom: out_db/$(self)
  - id: tax_lineage
    type:
      - 'null'
      - int
    doc: '0: don''t show, 1: add all lineage names, 2: add all lineage taxids'
    inputBinding:
      position: 104
      prefix: --tax-lineage
  - id: lca_ranks
    type:
      - 'null'
      - string
    doc: Add column with specified ranks (',' separated)
    inputBinding:
      position: 104
      prefix: --lca-ranks
  - id: pick_id_from
    type:
      - 'null'
      - int
    doc: Query 1, Target 2
    inputBinding:
      position: 104
      prefix: --pick-id-from
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
