cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methbat
  - joint-segment
label: methbat_joint-segment
doc: "Jointly segments a collection a samples into common methylation types\n\nTool
  homepage: https://github.com/PacificBiosciences/MethBat"
inputs:
  - id: condense_bed_labels
    type:
      - 'null'
      - boolean
    doc: Condenses the labels of output BED regions to abbreviated 
      representations
    inputBinding:
      position: 101
      prefix: --condense-bed-labels
  - id: enable_nodata_segments
    type:
      - 'null'
      - boolean
    doc: Enables the output of NoData haplotype segments
    inputBinding:
      position: 101
      prefix: --enable-nodata-segments
  - id: input_collection
    type: File
    doc: Input file defining a cohort to load into a background profile 
      (CSV/TSV)
    inputBinding:
      position: 101
      prefix: --input-collection
  - id: max_gap
    type:
      - 'null'
      - int
    doc: The maximum gap allowed between CpGs before they are automatically 
      segmented
    default: 1000
    inputBinding:
      position: 101
      prefix: --max-gap
  - id: max_unmethylated_combined
    type:
      - 'null'
      - float
    doc: The maximum combined methylation fraction to consider unmethylated 
      status
    default: 0.2
    inputBinding:
      position: 101
      prefix: --max-unmethylated-combined
  - id: min_abs_zscore
    type:
      - 'null'
      - float
    doc: The minimum absolute Z-score to split a segment, overrides 
      --target-confidence
    inputBinding:
      position: 101
      prefix: --min-abs-zscore
  - id: min_asm_abs_delta_mean
    type:
      - 'null'
      - float
    doc: The minimum absolute difference between mean haplotype methylation 
      fractions to consider ASM
    default: 0.5
    inputBinding:
      position: 101
      prefix: --min-asm-abs-delta-mean
  - id: min_asm_frac
    type:
      - 'null'
      - float
    doc: The minimum haplotagged fraction required to include ASM for a CpG
    default: 0.6
    inputBinding:
      position: 101
      prefix: --min-asm-frac
  - id: min_cpgs
    type:
      - 'null'
      - int
    doc: The minimum number of CpGs that can form a segment
    default: 20
    inputBinding:
      position: 101
      prefix: --min-cpgs
  - id: min_methylated_combined
    type:
      - 'null'
      - float
    doc: The minimum combined methylation fraction to consider methylated status
    default: 0.8
    inputBinding:
      position: 101
      prefix: --min-methylated-combined
  - id: min_sample_frac
    type:
      - 'null'
      - float
    doc: The minimum sample fraction required to include a CpG
    default: 0.9
    inputBinding:
      position: 101
      prefix: --min-sample-frac
  - id: target_confidence
    type:
      - 'null'
      - float
    doc: The target confidence level
    default: 0.99
    inputBinding:
      position: 101
      prefix: --target-confidence
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for signature building
    default: 1
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
