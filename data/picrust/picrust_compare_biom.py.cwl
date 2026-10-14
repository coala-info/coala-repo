cwlVersion: v1.2
class: CommandLineTool
baseCommand: compare_biom.py
label: picrust_compare_biom.py
doc: "Compare an observed BIOM table to an expected BIOM table and write accuracy values (TP, FP, FN, TN, sensitivity, specificity, etc.).\n\nTool homepage: https://github.com/picrust/picrust"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: exp_trait_table_fp
    type: File
    doc: 'the expected trait table (biom format)'
    inputBinding:
      position: 101
      prefix: --exp_trait_table_fp
  - id: compare_observations
    type:
      - 'null'
      - boolean
    doc: 'Calculate accuracy values by comparing between observations (instead of between samples)'
    inputBinding:
      position: 101
      prefix: --compare_observations
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: 'Convert both expected and observed tables to relative abundances'
    inputBinding:
      position: 101
      prefix: --normalize
  - id: limit_to_expected_observations
    type:
      - 'null'
      - boolean
    doc: 'Ignore observations that are not in the expected table'
    inputBinding:
      position: 101
      prefix: --limit_to_expected_observations
  - id: limit_to_observed_observations
    type:
      - 'null'
      - boolean
    doc: 'Ignore observations that are not in the observed table'
    inputBinding:
      position: 101
      prefix: --limit_to_observed_observations
  - id: shuffle_samples
    type:
      - 'null'
      - boolean
    doc: 'Shuffle sample ids randomly before measuring accuracy'
    inputBinding:
      position: 101
      prefix: --shuffle_samples
  - id: not_relative_abundance_scores
    type:
      - 'null'
      - boolean
    doc: 'Round numbers (instead of taking ceil() which is used for RA) before calculating TP,FP,FN,TN'
    inputBinding:
      position: 101
      prefix: --not_relative_abundance_scores
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Print information during execution'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_fp
    type: string
    doc: 'the output file'
    inputBinding:
      position: 102
      prefix: --output_fp
  - id: observed_table
    type: File
    doc: 'the observed trait table (biom format), given as positional argument'
    inputBinding:
      position: 103
outputs:
  - id: comparison
    type: File
    doc: 'the accuracy table'
    outputBinding:
      glob: $(inputs.output_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust:1.1.4--pyh24bf2e0_0
