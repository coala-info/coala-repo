cwlVersion: v1.2
class: CommandLineTool
baseCommand: [vcfAnnoSummaryLite]
label: rvtests_vcfAnnoSummaryLite
doc: "Summarize a VCF file (counts, dbSNP and HapMap overlap, Ts/Tv) per annotation type.\n\nTool homepage: https://github.com/zhanxw/rvtests"
inputs:
  - id: hapmap
    type: File
    doc: "Input HapMap File (.bim). The built-in default path does not exist in the image, so give this file."
    inputBinding:
      position: 101
      prefix: --hapmap
  - id: in_vcf
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: "Input VCF file (plain, bgzip, or BCF). Range filters need a tabix index (.tbi) beside it."
    inputBinding:
      position: 101
      prefix: --inVcf
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
  - id: snp
    type: File
    doc: "Input dbSNP File (.rod: chromosome, id, 0-based position). The built-in default path does not exist in the image, so give this file."
    inputBinding:
      position: 101
      prefix: --snp
outputs:
  - id: summary
    type: stdout
    doc: "Summary table printed by the tool"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2
stdout: $(inputs.in_vcf.basename).vcfAnnoSummaryLite.txt
