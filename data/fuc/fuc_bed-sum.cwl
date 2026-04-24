cwlVersion: v1.2
class: CommandLineTool
baseCommand: fuc_bed-sum
label: fuc_bed-sum
doc: "Summarize a BED file.\n\nThis command will compute various summary statistics
  for a BED file. The\nreturned statistics include the total numbers of probes and
  covered base\npairs for each chromosome.\n\nBy default, covered base pairs are displayed
  in bp, but if you prefer you\ncan, for example, use '--bases 1000' to display in
  kb.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: bed
    type: File
    doc: Input BED file.
    inputBinding:
      position: 1
  - id: bases
    type:
      - 'null'
      - int
    doc: 'Number to divide covered base pairs (default: 1).'
    inputBinding:
      position: 102
      prefix: --bases
  - id: decimals
    type:
      - 'null'
      - int
    doc: 'Number of decimals (default: 0).'
    inputBinding:
      position: 102
      prefix: --decimals
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_bed-sum.out
