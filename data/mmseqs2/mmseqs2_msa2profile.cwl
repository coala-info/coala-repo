cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - msa2profile
label: mmseqs2_msa2profile
doc: 'Convert a MSA DB to a profile DB.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: msa_db
    type: Directory
    doc: Input MSA database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.msa_db_name)
  - id: msa_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 2
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
  - id: match_mode
    type:
      - 'null'
      - int
    doc: '0: Columns that have a residue in the first sequence are kept, 1: columns that have
      a residue in --match-ratio of all sequences are kept'
    inputBinding:
      position: 104
      prefix: --match-mode
  - id: match_ratio
    type:
      - 'null'
      - float
    doc: Columns that have a residue in this ratio of all sequences are kept
    inputBinding:
      position: 104
      prefix: --match-ratio
  - id: pseudo_cnt_mode
    type:
      - 'null'
      - int
    doc: 'use 0: substitution-matrix or 1: context-specific pseudocounts'
    inputBinding:
      position: 104
      prefix: --pseudo-cnt-mode
  - id: pca
    type:
      - 'null'
      - float
    doc: Pseudo count admixture strength
    inputBinding:
      position: 104
      prefix: --pca
  - id: pcb
    type:
      - 'null'
      - float
    doc: 'Pseudo counts: Neff at half of maximum admixture (range 0.0-inf)'
    inputBinding:
      position: 104
      prefix: --pcb
  - id: wg
    type:
      - 'null'
      - int
    doc: Use global sequence weighting for profile calculation (0 or 1)
    inputBinding:
      position: 104
      prefix: --wg
  - id: filter_msa
    type:
      - 'null'
      - int
    doc: 'Filter msa: 0: do not filter, 1: filter'
    inputBinding:
      position: 104
      prefix: --filter-msa
  - id: filter_min_enable
    type:
      - 'null'
      - int
    doc: Only filter MSAs with more than N sequences, 0 always filters
    inputBinding:
      position: 104
      prefix: --filter-min-enable
  - id: cov
    type:
      - 'null'
      - float
    doc: Filter output MSAs using min. fraction of query residues covered by matched sequences
      [0.0,1.0]
    inputBinding:
      position: 104
      prefix: --cov
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
  - id: max_seq_id
    type:
      - 'null'
      - float
    doc: Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0]
    inputBinding:
      position: 104
      prefix: --max-seq-id
  - id: diff
    type:
      - 'null'
      - int
    doc: Filter MSAs by selecting most diverse set of sequences, keeping at least this many
      seqs in each MSA block of length 50
    inputBinding:
      position: 104
      prefix: --diff
  - id: msa_type
    type:
      - 'null'
      - int
    doc: 'MSA Type: 0: cA3M, 1: A3M, 2: FASTA'
    inputBinding:
      position: 104
      prefix: --msa-type
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
  - id: skip_query
    type:
      - 'null'
      - int
    doc: Skip the query sequence (0 or 1)
    inputBinding:
      position: 104
      prefix: --skip-query
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the profile database
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
