cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_alignment_vcf.py
label: vsnp_vsnp_alignment_vcf.py
doc: "Align reads to a reference FASTA with BWA, call variants and write VCF, BAM and statistics\
  \ (vSNP step 1 core).\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: read1
    type: File
    doc: 'Required: single read, R1 when Illumina read'
    inputBinding:
      position: 101
      prefix: -r1
  - id: read2
    type:
      - 'null'
      - File
    doc: 'Optional: R2 Illumina read'
    inputBinding:
      position: 101
      prefix: -r2
  - id: reference
    type: File
    doc: Provide reference FASTA file (the script requires -r).
    inputBinding:
      position: 101
      prefix: -r
  - id: gbk
    type:
      - 'null'
      - File
    doc: 'Optional: gbk to annotate VCF file'
    inputBinding:
      position: 101
      prefix: -g
  - id: skip_assembly
    type:
      - 'null'
      - boolean
    doc: skip assembly of unmapped reads
    inputBinding:
      position: 101
      prefix: -skip_assembly
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: alignment_vcf
    type:
      type: array
      items: File
    doc: VCF files written to the alignment folder
    outputBinding:
      glob: alignment/*.vcf
  - id: alignment_bam
    type: File
    doc: Sorted BAM file written to the alignment folder
    secondaryFiles:
      - pattern: .bai
        required: false
    outputBinding:
      glob: alignment/*.bam
  - id: stats
    type: File
    doc: Statistics workbook
    outputBinding:
      glob: '*_alignment_vcf_stats.xlsx'
  - id: unmapped_reads
    type: Directory
    doc: Unmapped reads and assembled contigs
    outputBinding:
      glob: unmapped_reads
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.read1)
        writable: true
      - entry: $(inputs.read2)
        writable: true
      - entry: $(inputs.reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_alignment_vcf.py.out
