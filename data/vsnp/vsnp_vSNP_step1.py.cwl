cwlVersion: v1.2
class: CommandLineTool
baseCommand: vSNP_step1.py
label: vsnp_vSNP_step1.py
doc: "vSNP step 1: Preprocessing and reference selection for variant calling.\n\n\
  Tool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: gbk
    type:
      - 'null'
      - File
    doc: 'Optional: gbk to annotate VCF file'
    inputBinding:
      position: 101
      prefix: --gbk
  - id: group
    type:
      - 'null'
      - string
    doc: 'Optional: group output via best_reference.py, ie specify TB or Bruc which
      initials spoligo or MLST generation'
    inputBinding:
      position: 101
      prefix: --group
  - id: read1
    type: File
    doc: 'Required: single read, R1 when Illumina read'
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: 'Optional: R2 Illumina read'
    inputBinding:
      position: 101
      prefix: --read2
  - id: reference
    type:
      - 'null'
      - File
      - string
    doc: 'Optional: Provide reference option or FASTA file. If neither are given,
      no -r option, then a TB/Brucella/paraTB best reference are searched'
    inputBinding:
      position: 101
      prefix: --reference
  - id: skip_assembly
    type:
      - 'null'
      - boolean
    doc: 'Optional: skip assembly of unmapped reads'
    inputBinding:
      position: 101
      prefix: --skip_assembly
  - id: table
    type:
      - 'null'
      - boolean
    doc: See reference options
    inputBinding:
      position: 101
      prefix: --table
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: step1_vcf
    type:
      - 'null'
      - type: array
        items: File
    doc: VCF files written by step 1 (alignment folder)
    outputBinding:
      glob: alignment/*.vcf
  - id: step1_bam
    type:
      - 'null'
      - File
    doc: Sorted BAM file written by step 1
    secondaryFiles:
      - pattern: .bai
        required: false
    outputBinding:
      glob: alignment/*.bam
  - id: step1_stats
    type:
      - 'null'
      - File
    doc: Statistics workbook written by step 1
    outputBinding:
      glob: '*_alignment_vcf_stats.xlsx'
  - id: unmapped_reads
    type:
      - 'null'
      - Directory
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vSNP_step1.py.out
