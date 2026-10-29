cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - profile2pssm
label: mmseqs2_profile2pssm
doc: 'Convert a profile DB to a tab-separated PSSM file.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: profile_db
    type: Directory
    doc: Input profile database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.profile_db_name)
  - id: profile_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_pssm_name
    type: string
    doc: Name of the output PSSM file
    inputBinding:
      position: 2
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
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    inputBinding:
      position: 104
      prefix: --sub-mat
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    inputBinding:
      position: 104
      prefix: --max-seq-len
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
  - id: db_output
    type:
      - 'null'
      - int
    doc: Return a result DB instead of a text file (0 or 1)
    inputBinding:
      position: 104
      prefix: --db-output
outputs:
  - id: output_pssm
    type: File
    doc: Tab-separated PSSM file
    outputBinding:
      glob: $(inputs.output_pssm_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
