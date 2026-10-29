cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - majoritylca
label: mmseqs2_majoritylca
doc: 'Compute the lowest common ancestor using majority voting.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: target_db
    type: Directory
    doc: Target database with taxonomy
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.target_db_name)
  - id: target_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: result_db
    type: Directory
    doc: Alignment result database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.result_db_name)
  - id: result_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 3
      valueFrom: out_db/$(self)
  - id: majority
    type:
      - 'null'
      - float
    doc: minimal fraction of agreement among taxonomically assigned sequences of a set
    inputBinding:
      position: 104
      prefix: --majority
  - id: vote_mode
    type:
      - 'null'
      - int
    doc: 'Mode of assigning weights to compute majority. 0: uniform, 1: minus log E-value,
      2: score'
    inputBinding:
      position: 104
      prefix: --vote-mode
  - id: lca_ranks
    type:
      - 'null'
      - string
    doc: Add column with specified ranks (',' separated)
    inputBinding:
      position: 104
      prefix: --lca-ranks
  - id: blacklist
    type:
      - 'null'
      - string
    doc: Comma separated list of ignored taxa in LCA computation
    inputBinding:
      position: 104
      prefix: --blacklist
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
    doc: Directory holding the taxonomy result database
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
arguments:
  - position: 200
    shellQuote: false
    valueFrom: '&& for l in out_db/*; do if [ -L "$l" ]; then t=`readlink -f "$l"`; rm "$l";
      cp -r "$t" "$l"; fi; done'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
