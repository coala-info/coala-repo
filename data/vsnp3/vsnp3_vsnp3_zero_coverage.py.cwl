cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_zero_coverage.py
label: vsnp3_vsnp3_zero_coverage.py
doc: "Add zero coverage positions to a VCF file. The result is written beside the input VCF.\n\
  \nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: fasta
    type: File
    doc: Reference used to build alignment
    inputBinding:
      position: 101
      prefix: -r
      valueFrom: $(self.basename)
  - id: bam
    type: File
    doc: bam file used to make VCF
    inputBinding:
      position: 101
      prefix: -b
      valueFrom: $(self.basename)
    secondaryFiles:
      - pattern: .bai
        required: false
  - id: vcf
    type: File
    doc: VCF file
    inputBinding:
      position: 101
      prefix: -c
      valueFrom: $(self.basename)
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
  - id: zero_coverage_vcf
    type: File
    doc: VCF file with zero coverage positions
    outputBinding:
      glob: '*_zc.vcf'
  - id: stats
    type:
      type: array
      items: File
    doc: Statistics workbook
    outputBinding:
      glob: '*_stats.xlsx'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta)
        writable: true
      - entry: $(inputs.bam)
        writable: true
      - entry: $(inputs.vcf)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_zero_coverage.py.stdout.txt
