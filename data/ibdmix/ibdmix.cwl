cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdmix
label: ibdmix
doc: "Find probable IBD regions\n\nTool homepage: https://github.com/PrincetonUniversity/IBDmix"
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
  - id: lod_threshold
    type:
      - 'null'
      - float
    doc: Threshold for emitting regions
    inputBinding:
      position: 6
      prefix: --LOD-threshold
  - id: minor_allele_count_threshold
    type:
      - 'null'
      - int
    doc: Threshold count for filtering minor alleles
    inputBinding:
      position: 7
      prefix: --minor-allele-count-threshold
  - id: archaic_error
    type:
      - 'null'
      - float
    doc: Allele error rate for archaic DNA
    inputBinding:
      position: 8
      prefix: --archaic-error
  - id: modern_error_max
    type:
      - 'null'
      - float
    doc: Maximum allele error rate for modern samples
    inputBinding:
      position: 9
      prefix: --modern-error-max
  - id: modern_error_proportion
    type:
      - 'null'
      - float
    doc: Ratio between allele error rate and minor allele frequency
    inputBinding:
      position: 10
      prefix: --modern-error-proportion
  - id: more_stats
    type:
      - 'null'
      - boolean
    doc: Flag to report additional region-level statistics
    inputBinding:
      position: 11
      prefix: --more-stats
  - id: inclusive_end
    type:
      - 'null'
      - boolean
    doc: Change regions to be closed over [start, end]
    inputBinding:
      position: 12
      prefix: --inclusive-end
  - id: write_snps
    type:
      - 'null'
      - boolean
    doc: Also include positions with positive LOD as a CSV list
    inputBinding:
      position: 13
      prefix: --write-snps
  - id: write_lods
    type:
      - 'null'
      - boolean
    doc: Also include LOD scores of positive LOD as a CSV list. Same order as
      SNPs.
    inputBinding:
      position: 14
      prefix: --write-lods
outputs:
  - id: ibd_regions
    type: File
    doc: Tab-delimited IBD regions (ID, chromosome, start, end, LOD)
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdmix:1.0.1--h4ac6f70_2
