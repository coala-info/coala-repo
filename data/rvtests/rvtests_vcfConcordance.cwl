cwlVersion: v1.2
class: CommandLineTool
baseCommand: [vcfConcordance]
label: rvtests_vcfConcordance
doc: "Calculate genotype concordance between a standard (reference) VCF file and one or more comparison VCF files, per person.\n\nTool homepage: https://github.com/zhanxw/rvtests"
inputs:
  - id: compare_vcfs
    type:
      type: array
      items: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: "VCF files to compare with the standard VCF file"
    inputBinding:
      position: 102
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
    doc: "Specify the file containing site to extract, please use chr:pos format."
    inputBinding:
      position: 101
      prefix: --siteFile
  - id: standard_vcf
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: "Standard (reference) VCF file"
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: concordance
    type: stdout
    doc: "Per-person concordance table"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
stdout: vcfConcordance.txt
