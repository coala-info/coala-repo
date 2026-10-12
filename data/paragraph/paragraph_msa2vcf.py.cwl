cwlVersion: v1.2
class: CommandLineTool
baseCommand: msa2vcf.py
label: paragraph_msa2vcf.py
doc: 'Convert a FASTA multiple sequence alignment into a VCF file relative to a reference.\n\nTool homepage: https://github.com/Illumina/paragraph'
inputs:
  - id: input
    type: File
    doc: 'Input Fasta MSA file'
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: 'Output VCF file'
    inputBinding:
      position: 2
  - id: reference
    type: File
    doc: 'Reference FASTA for checking REF'
    secondaryFiles:
      - .fai
    inputBinding:
      position: 101
      prefix: --reference-sequence
  - id: reference_chr
    type:
      - 'null'
      - string
    doc: 'Reference chromosome'
    inputBinding:
      position: 101
      prefix: --reference-chr
  - id: reference_start
    type:
      - 'null'
      - int
    doc: 'Reference start pos'
    inputBinding:
      position: 101
      prefix: --reference-start
  - id: bcftools
    type:
      - 'null'
      - string
    doc: 'Path to bcftools'
    inputBinding:
      position: 101
      prefix: --bcftools
outputs:
  - id: output
    type: File
    doc: 'Output VCF file'
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paragraph:2.3--h8908b6f_0
