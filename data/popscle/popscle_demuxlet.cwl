cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - popscle
  - demuxlet
label: popscle_demuxlet
doc: "The provided text contains container runtime error logs and does not include
  the help documentation for popscle demuxlet. Below is the structured representation
  based on the tool's standard CLI definition.\n\nTool homepage: https://github.com/statgen/popscle"
inputs:
  - id: alpha
    type:
      - 'null'
      - type: array
        items: float
    doc: Grid of alpha values for doublet detection.
    inputBinding:
      position: 101
      prefix: --alpha
  - id: doublet_prior
    type:
      - 'null'
      - float
    doc: Prior probability of doublets.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --doublet-prior
  - id: field
    type:
      - 'null'
      - string
    doc: VCF field to use for genotyping (e.g., GT, GP, PL).
    default: GT
    inputBinding:
      position: 101
      prefix: --field
  - id: sam
    type: File
    doc: Input SAM/BAM/CRAM file. Must be sorted by coordinates and indexed.
    inputBinding:
      position: 101
      prefix: --sam
  - id: sam_verbose
    type:
      - 'null'
      - int
    doc: Verbose output frequency for SAM file processing.
    default: 1000000
    inputBinding:
      position: 101
      prefix: --sam-verbose
  - id: tag_group
    type:
      - 'null'
      - string
    doc: Tag in the SAM file representing the cell barcode.
    default: CB
    inputBinding:
      position: 101
      prefix: --tag-group
  - id: tag_umi
    type:
      - 'null'
      - string
    doc: Tag in the SAM file representing the UMI.
    default: UB
    inputBinding:
      position: 101
      prefix: --tag-umi
  - id: vcf
    type: File
    doc: Input VCF/BCF file containing variant calls and genotypes for the individuals.
    inputBinding:
      position: 101
      prefix: --vcf
  - id: vcf_verbose
    type:
      - 'null'
      - int
    doc: Verbose output frequency for VCF file processing.
    default: 10000
    inputBinding:
      position: 101
      prefix: --vcf-verbose
outputs:
  - id: out
    type: File
    doc: Output file prefix.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popscle:0.1--ha0d7e29_1
