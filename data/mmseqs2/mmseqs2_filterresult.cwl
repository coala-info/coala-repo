cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - filterresult
label: mmseqs2_filterresult
doc: 'Pairwise alignment result filter.


  By Milot Mirdita <milot@mirdita.de>


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
  - id: result_db
    type: Directory
    doc: Result (alignment) database
    inputBinding:
      position: 3
      valueFrom: $(self.path)/$(inputs.result_db_name)
  - id: result_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 4
      valueFrom: out_db/$(self)
  - id: comp_bias_corr
    type:
      - 'null'
      - int
    doc: Correct for locally biased amino acid composition (range 0-1)
    inputBinding:
      position: 104
      prefix: --comp-bias-corr
  - id: comp_bias_corr_scale
    type:
      - 'null'
      - float
    doc: Correct for locally biased amino acid composition (range 0-1)
    inputBinding:
      position: 104
      prefix: --comp-bias-corr-scale
  - id: add_self_matches
    type:
      - 'null'
      - int
    doc: keep the query (representative) sequence (0 or 1)
    inputBinding:
      position: 104
      prefix: --add-self-matches
  - id: gap_open
    type:
      - 'null'
      - string
    doc: Gap open cost
    inputBinding:
      position: 104
      prefix: --gap-open
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: Gap extension cost
    inputBinding:
      position: 104
      prefix: --gap-extend
  - id: filter_min_enable
    type:
      - 'null'
      - int
    doc: Only filter MSAs with more than N sequences, 0 always filters
    inputBinding:
      position: 104
      prefix: --filter-min-enable
  - id: max_seq_id
    type:
      - 'null'
      - float
    doc: Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0]
    inputBinding:
      position: 104
      prefix: --max-seq-id
  - id: qid
    type:
      - 'null'
      - string
    doc: 'Reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0]
      Alternatively, can be a list of multiple thresholds: E.g.: 0.15,0.30,0.50 to defines
      filter buckets of ]0.15-0.30] and ]0.30-0.50]'
    inputBinding:
      position: 104
      prefix: --qid
  - id: qsc
    type:
      - 'null'
      - float
    doc: Reduce diversity of output MSAs using min. score per aligned residue with query sequences
      [-50.0,100.0]
    inputBinding:
      position: 104
      prefix: --qsc
  - id: cov
    type:
      - 'null'
      - float
    doc: Filter output MSAs using min. fraction of query residues covered by matched sequences
      [0.0,1.0]
    inputBinding:
      position: 104
      prefix: --cov
  - id: diff
    type:
      - 'null'
      - int
    doc: Filter MSAs by selecting most diverse set of sequences, keeping at least this many
      seqs in each MSA block of length 50
    inputBinding:
      position: 104
      prefix: --diff
  - id: allow_deletion
    type:
      - 'null'
      - int
    doc: Allow deletions in a MSA (0 or 1)
    inputBinding:
      position: 104
      prefix: --allow-deletion
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    inputBinding:
      position: 104
      prefix: --sub-mat
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
    doc: Directory holding the filtered alignment database
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
