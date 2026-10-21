cwlVersion: v1.2
class: CommandLineTool
baseCommand: [vcf2ld_gene]
label: rvtests_vcf2ld_gene
doc: "Calculate the covariance (LD) matrix of the variants in each gene.\n\nTool homepage: https://github.com/zhanxw/rvtests"
inputs:
  - id: gene
    type:
      - 'null'
      - string
    doc: "Specify which genes to test"
    inputBinding:
      position: 101
      prefix: --gene
  - id: gene_file
    type:
      - 'null'
      - File
    doc: "Specify a gene file (for burden tests)"
    inputBinding:
      position: 101
      prefix: --geneFile
  - id: in_vcf
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: "Input VCF file, bgzip-compressed with a tabix index for range filters."
    inputBinding:
      position: 101
      prefix: --inVcf
  - id: out
    type: string
    default: ld_gene
    doc: "Output prefix"
    inputBinding:
      position: 101
      prefix: --out
  - id: people_exclude_file
    type:
      - 'null'
      - File
    doc: "From given file, set IDs of people that will be excluded from study"
    inputBinding:
      position: 101
      prefix: --peopleExcludeFile
  - id: people_exclude_id
    type:
      - 'null'
      - type: array
        items: string
    doc: "Give IDs of people that will be excluded from study (comma separated)"
    inputBinding:
      position: 101
      itemSeparator: ','
      prefix: --peopleExcludeID
  - id: people_include_file
    type:
      - 'null'
      - File
    doc: "From given file, set IDs of people that will be included in study"
    inputBinding:
      position: 101
      prefix: --peopleIncludeFile
  - id: people_include_id
    type:
      - 'null'
      - type: array
        items: string
    doc: "Give IDs of people that will be included in study (comma separated)"
    inputBinding:
      position: 101
      itemSeparator: ','
      prefix: --peopleIncludeID
  - id: range_file
    type:
      - 'null'
      - File
    doc: "Specify the file containing ranges, please use chr:begin-end format."
    inputBinding:
      position: 101
      prefix: --rangeFile
  - id: range_list
    type:
      - 'null'
      - type: array
        items: string
    doc: "Specify some ranges to use, please use chr:begin-end format."
    inputBinding:
      position: 101
      itemSeparator: ','
      prefix: --rangeList
  - id: site_file
    type:
      - 'null'
      - File
    doc: "Specify the file containing sites to include, please use \"chr pos\" format."
    inputBinding:
      position: 101
      prefix: --siteFile
outputs:
  - id: cov
    type: File
    doc: "Covariance matrix per gene"
    outputBinding:
      glob: "$(inputs.out).cov"
  - id: out_log
    type: File
    doc: "Log file"
    outputBinding:
      glob: "$(inputs.out).log"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
