cwlVersion: v1.2
class: CommandLineTool
baseCommand: gt_lods
label: ibdmix_gt_lods
doc: "Calculate population specific LOD scores for all sites\n\nTool homepage:
  https://github.com/PrincetonUniversity/IBDmix"
inputs:
  - id: genotype
    type: File
    doc: The genotype file
    inputBinding:
      position: 1
      prefix: --genotype
  - id: output_name
    type: string
    doc: The output file location
    inputBinding:
      position: 2
      prefix: --output
  - id: sample
    type:
      - 'null'
      - File
    doc: File containing samples to select from genotype. Default to all samples
      in genotype.
    inputBinding:
      position: 3
      prefix: --sample
  - id: archaic
    type:
      - 'null'
      - string
    doc: Name of archaic sample, default to first sample in genotype file
    inputBinding:
      position: 4
      prefix: --archaic
  - id: mask
    type:
      - 'null'
      - File
    doc: Mask of regions to 'remove'. Regions in bed file have LOD set to 0
    inputBinding:
      position: 5
      prefix: --mask
  - id: minor_allele_count_threshold
    type:
      - 'null'
      - int
    doc: Threshold count for filtering minor alleles
    inputBinding:
      position: 6
      prefix: --minor-allele-count-threshold
  - id: archaic_error
    type:
      - 'null'
      - float
    doc: Allele error rate for archaic DNA
    inputBinding:
      position: 7
      prefix: --archaic-error
  - id: modern_error_max
    type:
      - 'null'
      - float
    doc: Maximum allele error rate for modern samples
    inputBinding:
      position: 8
      prefix: --modern-error-max
  - id: modern_error_proportion
    type:
      - 'null'
      - float
    doc: Ratio between allele error rate and minor allele frequency
    inputBinding:
      position: 9
      prefix: --modern-error-proportion
  - id: include_ninfs
    type:
      - 'null'
      - boolean
    doc: Include sites with -ninf as LOD scores. Will translate to -100 as the
      LOD score
    inputBinding:
      position: 10
      prefix: --include-ninfs
  - id: include_zeros
    type:
      - 'null'
      - boolean
    doc: Include sites where all LODs are 0. Commonly occurs for sites in masked
      regions.
    inputBinding:
      position: 11
      prefix: --include-zeros
outputs:
  - id: lods
    type: File
    doc: Per-site LOD scores
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdmix:1.0.1--h4ac6f70_2
