cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - consplice
  - constraint
  - calculate-oe
label: consplice_constraint_calculate-oe
doc: "Calculate the O/E and Percentile constraint scores.\n\nTool homepage: https://github.com/mikecormier/ConSplice"
inputs:
  - id: o_and_e_scores
    type: File
    doc: 'The path to the observed and expected scores file (from oe-counts).'
    inputBinding:
      position: 1
      prefix: --o-and-e-scores
  - id: substitution_matrix
    type: File
    doc: 'The substitution matrix used to calculate the substitution rate and the weights.'
    inputBinding:
      position: 1
      prefix: --substitution-matrix
  - id: out_file
    type: string
    doc: 'The name of the output file; it holds the input content plus O/E and Percentile score columns.'
    inputBinding:
      position: 1
      prefix: --out-file
  - id: pct_rec_rate
    type:
      - 'null'
      - float
    doc: 'The fraction of bases of a region that must be recovered for the region to be scored. Default = 0.8.'
    inputBinding:
      position: 1
      prefix: --pct-rec-rate
  - id: remove_duplicate
    type:
      - 'null'
      - boolean
    doc: 'Remove duplicate gene entries if they exist (use only when each region is a single gene).'
    inputBinding:
      position: 1
      prefix: --remove-duplicate
  - id: pct_col_name
    type:
      - 'null'
      - string
    doc: 'The name of the ConSplice percentile score column to create. Default = ''ConSplice_percentile''.'
    inputBinding:
      position: 1
      prefix: --pct-col-name
  - id: sort_by_pos
    type:
      - 'null'
      - boolean
    doc: 'Sort the output by chromosome and genomic position instead of by increasing percentile score.'
    inputBinding:
      position: 1
      prefix: --sort-by-pos
  - id: weights
    type:
      - 'null'
      - type: array
        items: string
    doc: 'The weights to apply when calculating the O/E scores: ''unweighted'' (default), ''linear'', ''PHRED'', ''One_minus_proportion'', ''One_over_proportion'', ''One_over_mutation_rate''.'
    inputBinding:
      position: 1
      prefix: --weights
  - id: spliceai_score_type
    type:
      - 'null'
      - string
    doc: 'How to use the SpliceAI score: ''max'', ''sum'' or ''splicing_unaware''. Default = ''sum''.'
    inputBinding:
      position: 1
      prefix: --spliceai-score-type
outputs:
  - id: output
    type: File
    doc: 'The output file.'
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
