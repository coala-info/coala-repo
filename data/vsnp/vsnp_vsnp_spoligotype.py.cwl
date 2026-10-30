cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp_spoligotype.py
label: vsnp_vsnp_spoligotype.py
doc: "Find the M. bovis spoligotype (octal code and SB number) by searching spacer sequences\
  \ in reads. Writes spoligo.txt.\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs:
  - id: read1
    type: File
    doc: 'Required: single read'
    inputBinding:
      position: 101
      prefix: -r1
  - id: read2
    type:
      - 'null'
      - File
    doc: 'Optional: paired read'
    inputBinding:
      position: 101
      prefix: -r2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: turn off map.pooling of samples
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: spoligo
    type: File
    doc: Spoligotype result
    outputBinding:
      glob: spoligo.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp_vsnp_spoligotype.py.out
