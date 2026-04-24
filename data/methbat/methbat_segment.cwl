cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methbat
  - segment
label: methbat_segment
doc: "Segments the output from pb-CpG-tools\n\nTool homepage: https://github.com/PacificBiosciences/MethBat"
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
  - id: enable_haplotype_segmentation
    type:
      - 'null'
      - boolean
    doc: Enables the segmentation of individual haplotypes
    inputBinding:
      position: 101
      prefix: --enable-haplotype-segmentation
  - id: enable_nodata_segments
    type:
      - 'null'
      - boolean
    doc: Enables the output of NoData haplotype segments
    inputBinding:
      position: 101
      prefix: --enable-nodata-segments
  - id: input_prefix
    type: string
    doc: Input prefix from pb-CpG-tools
    inputBinding:
      position: 101
      prefix: --input-prefix
  - id: max_gap
    type:
      - 'null'
      - int
    doc: The maximum gap allowed between CpGs before they are automatically 
      segmented
    inputBinding:
      position: 101
      prefix: --max-gap
  - id: max_unmethylated_combined
    type:
      - 'null'
      - float
    doc: The maximum combined methylation fraction to consider unmethylated 
      status
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
    inputBinding:
      position: 101
      prefix: --min-asm-abs-delta-mean
  - id: min_cpgs
    type:
      - 'null'
      - int
    doc: The minimum number of CpGs that can form a segment
    inputBinding:
      position: 101
      prefix: --min-cpgs
  - id: min_methylated_combined
    type:
      - 'null'
      - float
    doc: The minimum combined methylation fraction to consider methylated status
    inputBinding:
      position: 101
      prefix: --min-methylated-combined
  - id: target_confidence
    type:
      - 'null'
      - float
    doc: The target confidence level
    inputBinding:
      position: 101
      prefix: --target-confidence
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
