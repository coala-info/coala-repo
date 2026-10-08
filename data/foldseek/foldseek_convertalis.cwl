cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - foldseek
  - convertalis
label: foldseek_convertalis
doc: 'Convert an alignment database into a text file (BLAST tab, SAM, HTML or superposed
  PDB).


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/steineggerlab/foldseek'
inputs:
  - id: query_db
    type: Directory
    doc: Query database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.query_db_name)
  - id: query_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index,
      db.dbtype, db_h, db_ss, db_ca
  - id: target_db
    type: Directory
    doc: Target database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.target_db_name)
  - id: target_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index,
      db.dbtype, db_h, db_ss, db_ca
  - id: alignment_db
    type: Directory
    doc: Alignment (result) database
    inputBinding:
      position: 3
      valueFrom: $(self.path)/$(inputs.alignment_db_name)
  - id: alignment_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index,
      db.dbtype, db_h, db_ss, db_ca
  - id: alignment_file_name
    type: string
    doc: Name of the output file
    inputBinding:
      position: 4
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
  - id: db_output
    type:
      - 'null'
      - boolean
    doc: Return a result DB instead of a text file
    inputBinding:
      position: 104
      prefix: --db-output
  - id: exact_tmscore
    type:
      - 'null'
      - int
    doc: turn on fast exact TMscore (slow), default is approximate
    inputBinding:
      position: 104
      prefix: --exact-tmscore
  - id: format_mode
    type:
      - 'null'
      - int
    doc: 'Output format: 0: BLAST-TAB 1: SAM 2: BLAST-TAB + query/db length 3: Pretty
      HTML 4: BLAST-TAB + column headers 5: Calpha only PDB super-posed to query BLAST-TAB
      (0) and BLAST-TAB + column headers (4)support custom output formats (--format-output)
      (5) Superposed PDB files (Calpha only)'
    inputBinding:
      position: 104
      prefix: --format-mode
  - id: format_output
    type:
      - 'null'
      - string
    doc: 'Choose comma separated list of output columns from: query,target,evalue,gapopen,pident,fident,nident,qstart,qend,qlen
      tstart,tend,tlen,alnlen,raw,bits,cigar,qseq,tseq,qheader,theader,qaln,taln,mismatch,qcov,tcov
      qset,qsetid,tset,tsetid,taxid,taxname,taxlineage, lddt,lddtfull,qca,tca,t,u,qtmscore,ttmscore,alntmscore,rmsd,prob
      complexqtmscore,complexttmscore,complexu,complext,complexassignid'
    inputBinding:
      position: 104
      prefix: --format-output
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: Gap extension cost
    inputBinding:
      position: 104
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - string
    doc: Gap open cost
    inputBinding:
      position: 104
      prefix: --gap-open
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    inputBinding:
      position: 104
      prefix: --sub-mat
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: alignment_file
    type: File
    doc: Alignment table
    outputBinding:
      glob: $(inputs.alignment_file_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
