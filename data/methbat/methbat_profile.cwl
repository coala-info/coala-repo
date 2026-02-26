cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methbat
  - profile
label: methbat_profile
doc: "Create a CpG profile for a single dataset from pb-CpG-tools output\n\nTool homepage:
  https://github.com/PacificBiosciences/MethBat"
inputs:
  - id: input_prefix
    type: string
    doc: Input prefix from pb-CpG-tools
    inputBinding:
      position: 101
      prefix: --input-prefix
  - id: input_regions
    type:
      - 'null'
      - File
    doc: Optional input regions or background profile for CpG aggregation 
      (CSV/TSV)
    inputBinding:
      position: 101
      prefix: --input-regions
  - id: max_asm_fishers_exact
    type:
      - 'null'
      - float
    doc: The maximum Fisher's exact test p-value to consider ASM
    default: 0.01
    inputBinding:
      position: 101
      prefix: --max-asm-fishers-exact
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
  - id: min_abs_delta
    type:
      - 'null'
      - float
    doc: The minimum absolute delta from mean to flag a region as Hypo-/Hyper- 
      relative to the background population
    default: 0.2
    inputBinding:
      position: 101
      prefix: --min-abs-delta
  - id: min_abs_zscore
    type:
      - 'null'
      - float
    doc: The minimum absolute Z-score to flag a region as Hypo-/Hyper- relative 
      to the background population
    default: 3.0
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
  - id: min_asm_phased_fraction
    type:
      - 'null'
      - float
    doc: The minimum fraction of CpGs in a region that must be phased to 
      consider ASM
    default: 0.75
    inputBinding:
      position: 101
      prefix: --min-asm-phased-fraction
  - id: min_datasets
    type:
      - 'null'
      - int
    doc: The minimum number of background dataset required to flag a region 
      Hypo-/Hyper- relative to the background population; ASM requires this many
      phased datasets
    default: 10
    inputBinding:
      position: 101
      prefix: --min-datasets
  - id: min_methylated_combined
    type:
      - 'null'
      - float
    doc: The minimum combined methylation fraction to consider methylated status
    default: 0.8
    inputBinding:
      position: 101
      prefix: --min-methylated-combined
  - id: p_value
    type:
      - 'null'
      - float
    doc: ASM p-value cutoff for --output-asm-bed
    default: 0.05
    inputBinding:
      position: 101
      prefix: --p-value
  - id: profile_label
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the label from the background profile to compare against, can 
      be specified multiple times
    default: ALL
    inputBinding:
      position: 101
      prefix: --profile-label
outputs:
  - id: output_region_profile
    type:
      - 'null'
      - File
    doc: Optional output CpG aggregation file (CSV/TSV)
    outputBinding:
      glob: $(inputs.output_region_profile)
  - id: output_asm_bed
    type:
      - 'null'
      - File
    doc: Optional output BED file with individual ASM CpG loci
    outputBinding:
      glob: $(inputs.output_asm_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
