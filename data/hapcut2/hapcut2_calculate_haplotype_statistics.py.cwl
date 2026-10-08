cwlVersion: v1.2
class: CommandLineTool
baseCommand: calculate_haplotype_statistics.py
label: hapcut2_calculate_haplotype_statistics.py
doc: "Calculate statistics on haplotypes assembled using HapCUT2 or similar tools. Error rates for an assembled haplotype (vcf1 and optionally haplotype_blocks1) are computed with respect to a reference haplotype (vcf2 and optionally haplotype_blocks2). All files must contain information for one chromosome only.\n\nTool homepage: https://github.com/vibansal/HapCUT2/"
inputs:
  - id: vcf1
    type:
      - 'null'
      - type: array
        items: File
    doc: A phased, single sample VCF file to compute haplotype statistics
      on.
    inputBinding:
      position: 1
      prefix: -v1
  - id: vcf2
    type:
      - 'null'
      - type: array
        items: File
    doc: "A phased, single sample VCF file to use as the \"ground truth\" haplotype."
    inputBinding:
      position: 2
      prefix: -v2
  - id: haplotype_blocks1
    type:
      - 'null'
      - type: array
        items: File
    doc: "Override the haplotype information in \"-v1\" with the information in this HapCUT2-format haplotype block file. The VCF given with -v1 MUST be the same VCF used with HapCUT2."
    inputBinding:
      position: 3
      prefix: -h1
  - id: haplotype_blocks2
    type:
      - 'null'
      - type: array
        items: File
    doc: "Override the haplotype information in \"-v2\" with the information in this HapCUT2-format haplotype block file. The VCF given with -v2 MUST be the same VCF used with HapCUT2."
    inputBinding:
      position: 4
      prefix: -h2
  - id: indels
    type:
      - 'null'
      - boolean
    doc: "Use this flag to consider indel variants. Default: Indels ignored."
    inputBinding:
      position: 5
      prefix: --indels
outputs:
  - id: stdout
    type: stdout
    doc: Haplotype statistics (switch error rate, mismatch error rate, ...)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapcut2:1.3.4--h7e4f606_2
stdout: hapcut2_calculate_haplotype_statistics.py.out
