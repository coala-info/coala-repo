cwlVersion: v1.2
class: CommandLineTool
baseCommand: glimpse-bio_GLIMPSE2_split_reference
label: glimpse-bio_GLIMPSE2_split_reference
doc: "Split reference panel into binary GLIMPSE2 files\n\nTool homepage: https://odelaneau.github.io/GLIMPSE/"
inputs:
  - id: input_region
    type:
      - 'null'
      - string
    doc: Imputation region with buffers
    inputBinding:
      position: 101
      prefix: --input-region
  - id: keep_monomorphic_ref_sites
    type:
      - 'null'
      - boolean
    doc: (Expert setting) Keeps monomorphic markers in the reference panel 
      (removed by default)
    inputBinding:
      position: 101
      prefix: --keep-monomorphic-ref-sites
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    inputBinding:
      position: 101
      prefix: --log
  - id: map
    type:
      - 'null'
      - File
    doc: Genetic map
    inputBinding:
      position: 101
      prefix: --map
  - id: output_region
    type:
      - 'null'
      - string
    doc: Imputation region without buffers
    inputBinding:
      position: 101
      prefix: --output-region
  - id: reference
    type:
      - 'null'
      - File
    doc: Haplotype reference panel in VCF/BCF format
    inputBinding:
      position: 101
      prefix: --reference
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed of the random number generator
    default: 15052011
    inputBinding:
      position: 101
      prefix: --seed
  - id: sparse_maf
    type:
      - 'null'
      - float
    doc: (Expert setting) Rare variant threshold.
    default: 0.00100000005
    inputBinding:
      position: 101
      prefix: --sparse-maf
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Prefix of the output file (region and extension are automatically 
      added)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimpse-bio:2.0.1--ha5d29c5_3
