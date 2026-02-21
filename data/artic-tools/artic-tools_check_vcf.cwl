cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - artic-tools
  - check_vcf
label: artic-tools_check_vcf
doc: "Check a VCF file based on primer scheme info and user-defined cut offs\n\nTool
  homepage: https://github.com/will-rowe/artic-tools"
inputs:
  - id: vcf
    type: File
    doc: The input VCF file to filter
    inputBinding:
      position: 1
  - id: scheme
    type: File
    doc: The primer scheme to use
    inputBinding:
      position: 2
  - id: min_qual
    type:
      - 'null'
      - float
    doc: Minimum quality score to keep a variant
    default: 10.0
    inputBinding:
      position: 103
      prefix: --minQual
outputs:
  - id: summary_out
    type: File
    doc: Summary of variant checks will be written here (TSV format)
    outputBinding:
      glob: $(inputs.summary_out)
  - id: vcf_out
    type:
      - 'null'
      - File
    doc: If provided, will write variants that pass checks to this file
    outputBinding:
      glob: $(inputs.vcf_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic-tools:0.3.1--hf9554c4_7
