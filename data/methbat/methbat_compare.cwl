cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methbat
  - compare
label: methbat_compare
doc: "Compare sub-groups in a background/cohort profile\n\nTool homepage: https://github.com/PacificBiosciences/MethBat"
inputs:
  - id: baseline_category
    type:
      - 'null'
      - string
    doc: The baseline category to compare against, all outputs are relative to 
      baseline
    inputBinding:
      position: 101
      prefix: --baseline-category
  - id: compare_category
    type: string
    doc: The category we are using as the comparator to baseline
    inputBinding:
      position: 101
      prefix: --compare-category
  - id: input_profile
    type: File
    doc: Input cohort/background profile (CSV/TSV)
    inputBinding:
      position: 101
      prefix: --input-profile
  - id: min_delta
    type:
      - 'null'
      - float
    doc: The minimum absolute delta between the baseline and comparator to 
      assign a label
    inputBinding:
      position: 101
      prefix: --min-delta
  - id: min_samples
    type:
      - 'null'
      - int
    doc: The minimum sample count required in both baseline and comparator to 
      assign a label
    inputBinding:
      position: 101
      prefix: --min-samples
  - id: min_zscore
    type:
      - 'null'
      - float
    doc: The minimum absolute Z-score deviation between the baseline and 
      comparator to assign a label
    inputBinding:
      position: 101
      prefix: --min-zscore
outputs:
  - id: output_comparison
    type: File
    doc: Output comparison file (CSV/TSV)
    outputBinding:
      glob: $(inputs.output_comparison)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
