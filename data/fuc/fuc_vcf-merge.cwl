cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - vcf-merge
label: fuc_vcf-merge
doc: "Merge two or more VCF files.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: vcf_files
    type:
      type: array
      items: File
    doc: VCF files (compressed or uncompressed). Note that the 'chr' prefix in 
      contig names (e.g. 'chr1' vs. '1') will be automatically added or removed 
      as necessary to match the contig names of the first VCF.
    inputBinding:
      position: 1
  - id: collapse
    type:
      - 'null'
      - boolean
    doc: Use this flag to collapse duplicate records
    default: false
    inputBinding:
      position: 102
      prefix: --collapse
  - id: format
    type:
      - 'null'
      - string
    doc: FORMAT subfields to be retained (e.g. 'GT:AD:DP')
    default: GT
    inputBinding:
      position: 102
      prefix: --format
  - id: how
    type:
      - 'null'
      - string
    doc: Type of merge as defined in pandas.DataFrame.merge
    default: inner
    inputBinding:
      position: 102
      prefix: --how
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Use this flag to turn off sorting of records
    default: true
    inputBinding:
      position: 102
      prefix: --sort
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_vcf-merge.out
