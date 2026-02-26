cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ' fuc'
  - vcf-vep
label: fuc_vcf-vep
doc: "Filter a VCF file by annotations from Ensembl VEP.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: vcf
    type: File
    doc: VCF file annotated by Ensembl VEP (compressed or uncompressed).
    inputBinding:
      position: 1
  - id: expr
    type: string
    doc: Query expression to evaluate.
    inputBinding:
      position: 2
  - id: as_zero
    type:
      - 'null'
      - boolean
    doc: Use this flag to treat missing values as zero instead of NaN.
    inputBinding:
      position: 103
      prefix: --as_zero
  - id: opposite
    type:
      - 'null'
      - boolean
    doc: Use this flag to return only records that don't meet the said criteria.
    inputBinding:
      position: 103
      prefix: --opposite
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_vcf-vep.out
