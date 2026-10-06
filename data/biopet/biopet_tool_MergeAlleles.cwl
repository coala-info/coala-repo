cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - MergeAlleles
label: biopet_tool_MergeAlleles
doc: "Merge the alleles of several VCF files into one VCF.\n\nTool homepage: https://github.com/biopet/biopet"
inputs:
  - id: input_vcf
    type:
      type: array
      items: File
      inputBinding:
        prefix: --inputVcf
    doc: Input VCF files (at least 2)
    inputBinding:
      position: 101
    secondaryFiles:
      - pattern: .tbi
        required: false
  - id: output_vcf
    type: string
    doc: Output VCF file
    inputBinding:
      position: 101
      prefix: --outputVcf
  - id: reference
    type: File
    doc: Reference fasta
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
    inputBinding:
      position: 101
      prefix: --reference
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: output
    type: File
    doc: Merged VCF file
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
