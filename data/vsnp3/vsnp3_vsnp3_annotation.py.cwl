cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_annotation.py
label: vsnp3_vsnp3_annotation.py
doc: "Annotate one SNP position (amino acid change) from GenBank files. Used by vSNP to annotate\
  \ VCF files and SNP tables.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: gbk
    type:
      type: array
      items: File
    doc: Full path to .gbk files. Wildcard can be used
    inputBinding:
      position: 101
      prefix: -g
  - id: abs_pos
    type: string
    doc: Absolute position, example NC_017250.1:264518
    inputBinding:
      position: 101
      prefix: -p
  - id: snp_nt
    type:
      - 'null'
      - string
    doc: Position alt call, example T
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_annotation.py.stdout.txt
