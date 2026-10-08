cwlVersion: v1.2
class: CommandLineTool
baseCommand: GLIMPSE2_split_reference
label: glimpse-bio_GLIMPSE2_split_reference
doc: "Split reference panel into binary GLIMPSE2 files\n\nTool homepage: https://github.com/odelaneau/GLIMPSE"
inputs:
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed of the random number generator"
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads"
    inputBinding:
      position: 101
      prefix: --threads
  - id: reference
    type: File
    doc: "Haplotype reference panel in VCF/BCF format"
    secondaryFiles:
      - pattern: '.csi'
        required: false
      - pattern: '.tbi'
        required: false
    inputBinding:
      position: 101
      prefix: --reference
  - id: map
    type:
      - 'null'
      - File
    doc: "Genetic map"
    inputBinding:
      position: 101
      prefix: --map
  - id: input_region
    type: string
    doc: "Imputation region with buffers"
    inputBinding:
      position: 101
      prefix: --input-region
  - id: output_region
    type: string
    doc: "Imputation region without buffers"
    inputBinding:
      position: 101
      prefix: --output-region
  - id: sparse_maf
    type:
      - 'null'
      - float
    doc: "(Expert setting) Rare variant threshold."
    inputBinding:
      position: 101
      prefix: --sparse-maf
  - id: keep_monomorphic_ref_sites
    type:
      - 'null'
      - boolean
    doc: "(Expert setting) Keeps monomorphic markers in the reference panel (removed by default)"
    inputBinding:
      position: 101
      prefix: --keep-monomorphic-ref-sites
  - id: output_path
    type: string
    doc: "Prefix of the output file (region and extension are automatically added)"
    inputBinding:
      position: 102
      prefix: --output
  - id: log_path
    type:
      - 'null'
      - string
    doc: "Log file"
    inputBinding:
      position: 101
      prefix: --log
outputs:
  - id: output
    type: File[]
    doc: Binary reference panel file(s), one per region
    outputBinding:
      glob: $(inputs.output_path)*.bin
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimpse-bio:2.0.1--ha5d29c5_3
