cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - consplice
  - constraint
  - agg-overlapping-reg
label: consplice_constraint_agg-overlapping-reg
doc: "Combine overlapping regional constraint scores into an aggregated score using the region's step size. All regions that intersect the user defined step size are combined into a single score.\n\nTool homepage: https://github.com/mikecormier/ConSplice"
inputs:
  - id: score_file
    type: File
    doc: 'The path to the regional score file to combine scores for.'
    inputBinding:
      position: 1
      prefix: --score-file
  - id: score_field
    type: string
    doc: 'The name of the O/E score field within the regional score file to combine.'
    inputBinding:
      position: 1
      prefix: --score-field
  - id: step_size
    type: int
    doc: 'The step size used to create the overlapping regions.'
    inputBinding:
      position: 1
      prefix: --step-size
  - id: out_file
    type: string
    doc: 'The name of the output file to create.'
    inputBinding:
      position: 1
      prefix: --out-file
  - id: new_score_name
    type:
      - 'null'
      - string
    doc: 'The name of the new score column. Default = ''Aggregated_ConSplice_O/E''.'
    inputBinding:
      position: 1
      prefix: --new-score-name
  - id: new_pctl_name
    type:
      - 'null'
      - string
    doc: 'The name of the new percentile score column. Default = ''Aggregated_ConSplice_Percentile''.'
    inputBinding:
      position: 1
      prefix: --new-pctl-name
  - id: invert_pctl
    type:
      - 'null'
      - boolean
    doc: 'Invert the new scores before converting them to percentiles (set when smaller scores mean higher percentiles).'
    inputBinding:
      position: 1
      prefix: --invert-pctl
  - id: agg_type
    type:
      - 'null'
      - string
    doc: 'How to aggregate the overlapping scores: ''mean'' or ''median''. Default = ''median''.'
    inputBinding:
      position: 1
      prefix: --agg-type
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
