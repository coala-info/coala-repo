cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - offsetalignment
label: mmseqs2_offsetalignment
doc: 'Offset alignment by ORF start position.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: query_db
    type: Directory
    doc: Query database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.query_db_name)
  - id: query_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: query_orf_db
    type: Directory
    doc: Query ORF database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.query_orf_db_name)
  - id: query_orf_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: target_db
    type: Directory
    doc: Target database
    inputBinding:
      position: 3
      valueFrom: $(self.path)/$(inputs.target_db_name)
  - id: target_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: target_orf_db
    type: Directory
    doc: Target ORF database
    inputBinding:
      position: 4
      valueFrom: $(self.path)/$(inputs.target_orf_db_name)
  - id: target_orf_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: aln_db
    type: Directory
    doc: Alignment database
    inputBinding:
      position: 5
      valueFrom: $(self.path)/$(inputs.aln_db_name)
  - id: aln_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 6
      valueFrom: out_db/$(self)
  - id: search_type
    type:
      - 'null'
      - int
    doc: 'Search type 0: auto 1: amino acid, 2: translated, 3: nucleotide, 4: translated nucleotide
      alignment'
    inputBinding:
      position: 104
      prefix: --search-type
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
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch'
    inputBinding:
      position: 104
      prefix: --db-load-mode
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
  - id: chain_alignments
    type:
      - 'null'
      - int
    doc: Chain overlapping alignments
    inputBinding:
      position: 104
      prefix: --chain-alignments
  - id: merge_query
    type:
      - 'null'
      - int
    doc: Combine ORFs/split sequences to a single entry
    inputBinding:
      position: 104
      prefix: --merge-query
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the offset alignment database
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
