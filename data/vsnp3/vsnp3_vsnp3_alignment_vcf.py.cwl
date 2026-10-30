cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_alignment_vcf.py
label: vsnp3_vsnp3_alignment_vcf.py
doc: "Align reads to one or more reference FASTA files, call variants, add zero coverage and\
  \ write VCF, BAM and statistics.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Force output files to this sample name
    inputBinding:
      position: 101
      prefix: -n
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
    type:
      - 'null'
      - &id001
        type: array
        items: File
    doc: FASTA file to be used as reference. Multiple can be specified with wildcard
    inputBinding:
      position: 101
      prefix: -r
  - id: nanopore
    type:
      - 'null'
      - boolean
    doc: Beta, if true run alignment with minimap2 map-ont option
    inputBinding:
      position: 101
      prefix: -o
  - id: gbk
    type:
      - 'null'
      - *id001
    doc: 'Optional: gbk to annotate VCF file. Multiple can be specified with wildcard'
    inputBinding:
      position: 101
      prefix: -b
  - id: assemble_unmap
    type:
      - 'null'
      - boolean
    doc: skip assembly of unmapped reads
    inputBinding:
      position: 101
      prefix: -assemble_unmap
  - id: debug
    type:
      - 'null'
      - boolean
    doc: keep temp file
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: alignment
    type: Directory
    doc: Alignment folder with BAM, VCF files and unmapped reads
    outputBinding:
      glob: alignment_*
  - id: stats
    type: File
    doc: Statistics workbook
    outputBinding:
      glob: '*_stats.xlsx'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_alignment_vcf.py.stdout.txt
