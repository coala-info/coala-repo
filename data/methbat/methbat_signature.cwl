cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methbat
  - signature
label: methbat_signature
doc: "Identify signature regions distinguishing cases from controls\n\nTool homepage:
  https://github.com/PacificBiosciences/MethBat"
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
    type:
      - 'null'
      - string
    doc: The category we are using as the comparator to baseline
    inputBinding:
      position: 101
      prefix: --compare-category
  - id: input_collection
    type: File
    doc: Input file defining a cohort to load into the signature
    inputBinding:
      position: 101
      prefix: --input-collection
  - id: max_gap
    type:
      - 'null'
      - int
    doc: The maximum gap allowed between CpGs before they are automatically 
      segmented
    inputBinding:
      position: 101
      prefix: --max-gap
  - id: min_abs_zscore
    type:
      - 'null'
      - float
    doc: The minimum absolute Z-score to split a segment, overrides 
      --target-confidence
    inputBinding:
      position: 101
      prefix: --min-abs-zscore
  - id: min_cpgs
    type:
      - 'null'
      - int
    doc: The minimum number of CpGs that can form a segment
    inputBinding:
      position: 101
      prefix: --min-cpgs
  - id: min_delta
    type:
      - 'null'
      - float
    doc: The minimum average delta between the baseline and comparator to 
      consider a region for the signature
    inputBinding:
      position: 101
      prefix: --min-delta
  - id: min_sample_frac
    type:
      - 'null'
      - float
    doc: The minimum sample fraction required in both baseline and comparator to
      assess a region
    inputBinding:
      position: 101
      prefix: --min-sample-frac
  - id: min_zscore
    type:
      - 'null'
      - float
    doc: The minimum absolute Z-score deviation between the baseline and 
      comparator to consider a region for the signature
    inputBinding:
      position: 101
      prefix: --min-zscore
  - id: target_confidence
    type:
      - 'null'
      - float
    doc: The target confidence level
    inputBinding:
      position: 101
      prefix: --target-confidence
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for signature building
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_prefix
    type: File
    doc: Output prefix
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
