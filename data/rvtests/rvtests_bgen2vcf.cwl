cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bgen2vcf]
label: rvtests_bgen2vcf
doc: "Convert a BGEN file to a bgzip-compressed VCF file (output <out>.vcf.gz).\n\nTool homepage: https://github.com/zhanxw/rvtests"
inputs:
  - id: hide_gt
    type:
      - 'null'
      - boolean
    doc: "Do not call genotypes by skipping the GT tag"
    inputBinding:
      position: 101
      prefix: --hideGT
  - id: hide_var_id
    type:
      - 'null'
      - boolean
    doc: "Do not output Variant ID (only output rsid)"
    inputBinding:
      position: 101
      prefix: --hideVarId
  - id: in_bgen
    type: File
    secondaryFiles:
      - pattern: .bgi
        required: false
    doc: "Input BGEN File. A .bgi index beside it is needed for range filters."
    inputBinding:
      position: 101
      prefix: --inBgen
  - id: in_bgen_sample
    type:
      - 'null'
      - File
    doc: "Input SAMPLE file for the BGEN File"
    inputBinding:
      position: 101
      prefix: --inBgenSample
  - id: out
    type: string
    default: rvtest
    doc: "Output prefix (the VCF is written to <out>.vcf.gz)"
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
  - id: show_ds
    type:
      - 'null'
      - boolean
    doc: "Calculate bi-allelic dosage using the DS tag"
    inputBinding:
      position: 101
      prefix: --showDS
  - id: site_file
    type:
      - 'null'
      - File
    doc: "Specify the file containing site to extract, please use chr:pos format."
    inputBinding:
      position: 101
      prefix: --siteFile
outputs:
  - id: out_vcf
    type: File
    doc: "Converted bgzip-compressed VCF file"
    outputBinding:
      glob: "$(inputs.out).vcf.gz"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
