cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - aggregatetax
label: mmseqs2_aggregatetax
doc: 'Aggregate multiple taxon labels per sequence to a single label per set (for example
  per contig).


  By Eli Levy Karin <eli.levy.karin@gmail.com>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: tax_seq_db
    type: Directory
    doc: Sequence database that carries taxonomy
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.tax_seq_db_name)
  - id: tax_seq_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: set_to_seq_map
    type: Directory
    doc: Database that maps each set to its sequences
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.set_to_seq_map_name)
  - id: set_to_seq_map_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: tax_res_per_seq_db
    type: Directory
    doc: Taxonomy result database with one entry per sequence
    inputBinding:
      position: 3
      valueFrom: $(self.path)/$(inputs.tax_res_per_seq_db_name)
  - id: tax_res_per_seq_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_tax_res_per_set_db_name
    type: string
    doc: Name (prefix) of the output taxonomy result database, written inside the output directory
    inputBinding:
      position: 4
      valueFrom: out_db/$(self)
  - id: lca_ranks
    type:
      - 'null'
      - string
    doc: Add column with specified ranks (',' separated)
    inputBinding:
      position: 104
      prefix: --lca-ranks
  - id: tax_lineage
    type:
      - 'null'
      - int
    doc: '0: don''t show, 1: add all lineage names, 2: add all lineage taxids'
    inputBinding:
      position: 104
      prefix: --tax-lineage
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
