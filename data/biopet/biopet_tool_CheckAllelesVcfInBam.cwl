cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - CheckAllelesVcfInBam
label: biopet_tool_CheckAllelesVcfInBam
doc: "Check which alleles of VCF records are present in reads of BAM files.\n\nTool homepage:\
  \ https://github.com/biopet/biopet"
inputs:
  - id: input_file
    type: File
    doc: VCF file
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: output_file
    type: string
    doc: output VCF file name
    inputBinding:
      position: 101
      prefix: --outputFile
  - id: sample
    type:
      type: array
      items: string
      inputBinding:
        prefix: --sample
    doc: sample name (one per bam file, same order)
    inputBinding:
      position: 101
  - id: bam
    type:
      type: array
      items: File
      inputBinding:
        prefix: --bam
    doc: bam file, from which the variants (VCF files) were called
    inputBinding:
      position: 101
    secondaryFiles:
      - pattern: .bai
        required: false
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality score for a read to be taken into account
    inputBinding:
      position: 101
      prefix: --min_mapping_quality
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
  - id: output_vcf
    type: File
    doc: Output VCF file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
