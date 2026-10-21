cwlVersion: v1.2
class: CommandLineTool
baseCommand: [vcfExtractSite]
label: rvtests_vcfExtractSite
doc: "Extract the sites listed in a site file (.rod format) from a VCF file; with --inverse, keep the sites not listed.\n\nTool homepage: https://github.com/zhanxw/rvtests"
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
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: "Inverse site"
    inputBinding:
      position: 101
      prefix: --inverse
  - id: out_vcf
    type: string
    default: extracted.vcf
    doc: "Output VCF file (a name ending in .gz is bgzip compressed)"
    inputBinding:
      position: 101
      prefix: --outVcf
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
  - id: site
    type: File
    doc: "Input site file (.rod file: 0-based position). The built-in default path does not exist in the image, so give this file."
    inputBinding:
      position: 101
      prefix: --site
  - id: snp_only
    type:
      - 'null'
      - boolean
    doc: "Specify only extract SNP site"
    inputBinding:
      position: 101
      prefix: --snpOnly
outputs:
  - id: extracted_vcf
    type: File
    doc: "Extracted VCF file"
    outputBinding:
      glob: "$(inputs.out_vcf)"
  - id: extract_log
    type: stdout
    doc: "Record counts printed by the tool"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
stdout: $(inputs.in_vcf.basename).vcfExtractSite.out
