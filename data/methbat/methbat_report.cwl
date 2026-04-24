cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methbat
  - report
label: methbat_report
doc: "Generate a report for a single dataset from pb-CpG-tools output\n\nTool homepage:
  https://github.com/PacificBiosciences/MethBat"
inputs:
  - id: input_prefix
    type: string
    doc: Input prefix from pb-CpG-tools
    inputBinding:
      position: 101
      prefix: --input-prefix
  - id: input_regions
    type: File
    doc: Input regions to report (CSV/TSV)
    inputBinding:
      position: 101
      prefix: --input-regions
  - id: max_asm_fishers_exact
    type:
      - 'null'
      - float
    doc: The maximum Fisher's exact test p-value to consider ASM
    inputBinding:
      position: 101
      prefix: --max-asm-fishers-exact
  - id: max_unmethylated_combined
    type:
      - 'null'
      - float
    doc: The maximum combined methylation fraction to consider unmethylated 
      status
    inputBinding:
      position: 101
      prefix: --max-unmethylated_combined
  - id: min_asm_abs_delta_mean
    type:
      - 'null'
      - float
    doc: The minimum absolute difference between mean haplotype methylation 
      fractions to consider ASM
    inputBinding:
      position: 101
      prefix: --min-asm-abs-delta-mean
  - id: min_asm_phased_fraction
    type:
      - 'null'
      - float
    doc: The minimum fraction of CpGs in a region that must be phased to 
      consider ASM
    inputBinding:
      position: 101
      prefix: --min-asm-phased-fraction
  - id: min_haplotype_coverage
    type:
      - 'null'
      - int
    doc: The minimum coverage of a haplotype to consider it "normal" for QC 
      purposes
    inputBinding:
      position: 101
      prefix: --min-haplotype-coverage
  - id: min_methylated_combined
    type:
      - 'null'
      - float
    doc: The minimum combined methylation fraction to consider methylated status
    inputBinding:
      position: 101
      prefix: --min-methylated-combined
  - id: min_weakasm_abs_delta_mean
    type:
      - 'null'
      - float
    doc: The minimum absolute difference between mean haplotype methylation 
      fractions to consider Weak ASM
    inputBinding:
      position: 101
      prefix: --min-weakasm-abs-delta-mean
outputs:
  - id: output_report
    type: File
    doc: Output report file (CSV/TSV)
    outputBinding:
      glob: $(inputs.output_report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
