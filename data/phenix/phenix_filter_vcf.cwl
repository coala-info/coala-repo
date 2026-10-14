cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phenix.py
  - filter_vcf
label: phenix_filter_vcf
doc: "Filter the VCF using provided filters.\n\nTool homepage: https://github.com/phe-bioinformatics/PHEnix"
inputs:
  - id: vcf
    type: File
    doc: "VCF file to (re)filter."
    inputBinding:
      position: 1
      prefix: --vcf
  - id: filters
    type:
      - 'null'
      - string
    doc: "Filter(s) to apply as key:threshold pairs, separated by comma. Recommendations: GATK: mq_score:30,min_depth:10,ad_ratio:0.9 Mpileup: mq_score:30,min_depth:10,dp4_ratio:0.9"
    inputBinding:
      position: 2
      prefix: --filters
  - id: config
    type:
      - 'null'
      - File
    doc: "Config with filters in YAML format, e.g. filters: - key: value"
    inputBinding:
      position: 3
      prefix: --config
  - id: output
    type: string
    doc: "Location for filtered VCF to be written."
    inputBinding:
      position: 4
      prefix: --output
  - id: reference
    type:
      - 'null'
      - File
    doc: "mpileup version <= 1.3 do not output all positions. This is required to fix reference base in VCF."
    inputBinding:
      position: 5
      prefix: --reference
  - id: only_good
    type:
      - 'null'
      - boolean
    doc: "Write only variants that PASS all filters (default all variants are written)."
    inputBinding:
      position: 6
      prefix: --only-good
outputs:
  - id: filtered_vcf
    type:
      - File
    doc: "Filtered VCF file"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phenix:1.4.1a--py27h24bf2e0_0
