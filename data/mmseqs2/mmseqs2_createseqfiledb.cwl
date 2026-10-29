cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - createseqfiledb
label: mmseqs2_createseqfiledb
doc: 'Create a database of unaligned FASTA entries, one per cluster, from a sequence database
  and a cluster database.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: sequence_db
    type: Directory
    doc: Sequence database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.sequence_db_name)
  - id: sequence_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: result_db
    type: Directory
    doc: Cluster (result) database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.result_db_name)
  - id: result_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_fasta_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 3
      valueFrom: out_db/$(self)
  - id: min_sequences
    type:
      - 'null'
      - int
    doc: Minimum number of sequences a cluster may contain
    inputBinding:
      position: 104
      prefix: --min-sequences
  - id: max_sequences
    type:
      - 'null'
      - int
    doc: Maximum number of sequences a cluster may contain
    inputBinding:
      position: 104
      prefix: --max-sequences
  - id: hh_format
    type:
      - 'null'
      - int
    doc: Format entries to use with hhsuite (for singleton clusters) (0 or 1)
    inputBinding:
      position: 104
      prefix: --hh-format
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch'
    inputBinding:
      position: 104
      prefix: --db-load-mode
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
