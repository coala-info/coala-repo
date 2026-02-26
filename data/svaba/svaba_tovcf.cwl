cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svaba
  - tovcf
label: svaba_tovcf
doc: "Convert a *bps.txt.gz file to a *vcf file\n\nTool homepage: https://github.com/walaj/svaba"
inputs:
  - id: bam
    type: File
    doc: BAM file used to grab header from
    inputBinding:
      position: 101
      prefix: --bam
  - id: id_string
    type: string
    doc: String specifying the analysis ID to be used as part of ID common.
    inputBinding:
      position: 101
      prefix: --id-string
  - id: input_bps
    type: File
    doc: Original bps.txt.gz file
    inputBinding:
      position: 101
      prefix: --input-bps
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Flag to make more verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svaba:1.2.0--h69ac913_1
stdout: svaba_tovcf.out
