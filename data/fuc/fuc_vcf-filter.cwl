cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - vcf-filter
label: fuc_vcf-filter
doc: "Filter a VCF file.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: vcf
    type: File
    doc: VCF file (compressed or uncompressed).
    inputBinding:
      position: 1
  - id: drop_duplicates
    type:
      - 'null'
      - type: array
        items: string
    doc: Only consider certain columns for identifying duplicates, by default 
      use all of the columns.
    inputBinding:
      position: 102
      prefix: --drop_duplicates
  - id: expression
    type:
      - 'null'
      - string
    doc: Expression to evaluate.
    inputBinding:
      position: 102
      prefix: --expr
  - id: filter_empty
    type:
      - 'null'
      - boolean
    doc: Use this flag to remove rows with no genotype calls at all.
    inputBinding:
      position: 102
      prefix: --filter_empty
  - id: greedy
    type:
      - 'null'
      - boolean
    doc: Use this flag to mark even ambiguous genotypes as missing.
    inputBinding:
      position: 102
      prefix: --greedy
  - id: opposite
    type:
      - 'null'
      - boolean
    doc: Use this flag to mark all genotypes that do not satisfy the query 
      expression as missing and leave those that do intact.
    inputBinding:
      position: 102
      prefix: --opposite
  - id: samples_file
    type:
      - 'null'
      - File
    doc: File of sample names to apply the marking (one sample per line).
    inputBinding:
      position: 102
      prefix: --samples
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_vcf-filter.out
