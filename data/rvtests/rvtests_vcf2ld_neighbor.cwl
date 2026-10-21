cwlVersion: v1.2
class: CommandLineTool
baseCommand: [vcf2ld_neighbor]
label: rvtests_vcf2ld_neighbor
doc: "Calculate LD between each selected site and the previous variant in the VCF file.\n\nTool homepage: https://github.com/zhanxw/rvtests"
inputs:
  - id: in_vcf
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: "Input VCF file (plain, bgzip, or BCF). Range filters need a tabix index (.tbi) beside it."
    inputBinding:
      position: 101
      prefix: --inVcf
  - id: out_ld
    type: string
    default: ld_neighbor
    doc: "Output file prefix (the table is written to <outLD>.ld)"
    inputBinding:
      position: 101
      prefix: --outLD
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
    doc: "Specify the file to contain the site to be extract from the vcf file."
    inputBinding:
      position: 101
      prefix: --siteFile
  - id: site_id
    type:
      - 'null'
      - type: array
        items: string
    doc: "Specify the sites to be extracted from the vcf file, separated by comma (chr:pos)"
    inputBinding:
      position: 101
      itemSeparator: ','
      prefix: --siteID
outputs:
  - id: ld
    type: File
    doc: "LD table (ChrA, PosA, MarkerA, ChrB, PosB, MarkerB, N00, N01, N10, N11, D, Dprime, r)"
    outputBinding:
      glob: "$(inputs.out_ld).ld"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
