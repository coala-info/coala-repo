cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - fwbw
label: mmseqs2_fwbw
doc: 'Forward Backward Alignment.


  By Gyuri Kim <gyuribio@snu.ac.kr> & Soohyun Kim <sd20163818@snu.ac.kr>


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
  - id: target_db
    type: Directory
    doc: Target database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.target_db_name)
  - id: target_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: alignment_db
    type: Directory
    doc: Alignment database
    inputBinding:
      position: 3
      valueFrom: $(self.path)/$(inputs.alignment_db_name)
  - id: alignment_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 4
      valueFrom: out_db/$(self)
  - id: e
    type:
      - 'null'
      - float
    doc: List matches below this E-value (range 0.0-inf)
    inputBinding:
      position: 104
      prefix: -e
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity (for clustering) (range 0.0-1.0)
    inputBinding:
      position: 104
      prefix: --min-seq-id
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length (range 0-INT_MAX)
    inputBinding:
      position: 104
      prefix: --min-aln-len
  - id: seq_id_mode
    type:
      - 'null'
      - int
    doc: '0: alignment length 1: shorter, 2: longer sequence'
    inputBinding:
      position: 104
      prefix: --seq-id-mode
  - id: c
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see --cov-mode)
    inputBinding:
      position: 104
      prefix: -c
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: '0: coverage of query and target 1: coverage of target 2: coverage of query 3: target
      seq. length has to be at least x% of query length 4: query seq. length has to be at
      least x% of target length 5: short seq. needs to be at least x% of the other seq. length'
    inputBinding:
      position: 104
      prefix: --cov-mode
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
  - id: mact
    type:
      - 'null'
      - float
    doc: Maximum accuracy threshold
    inputBinding:
      position: 104
      prefix: --mact
  - id: fwbw_gapopen
    type:
      - 'null'
      - float
    doc: Gap open penalty for fwbw
    inputBinding:
      position: 104
      prefix: --fwbw-gapopen
  - id: fwbw_gapextend
    type:
      - 'null'
      - float
    doc: Gap extension penalty for fwbw
    inputBinding:
      position: 104
      prefix: --fwbw-gapextend
  - id: temperature
    type:
      - 'null'
      - float
    doc: Temperature for forward-backward
    inputBinding:
      position: 104
      prefix: --temperature
  - id: blocklen
    type:
      - 'null'
      - int
    doc: Block length for forward-backward
    inputBinding:
      position: 104
      prefix: --blocklen
  - id: fwbw_backtrace_mode
    type:
      - 'null'
      - int
    doc: 'Backtrace mode 0: no backtrace, 1: local'
    inputBinding:
      position: 104
      prefix: --fwbw-backtrace-mode
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the new alignment database
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
