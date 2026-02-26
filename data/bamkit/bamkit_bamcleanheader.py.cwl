cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamkit_bamcleanheader.py
label: bamkit_bamcleanheader.py
doc: "remove illegal and malformed fields from a BAM file's header\n\nTool homepage:
  https://github.com/hall-lab/bamkit"
inputs:
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: SAM/BAM file to inject header lines into. If '-' or absent then 
      defaults to stdin.
    inputBinding:
      position: 1
  - id: is_sam
    type:
      - 'null'
      - boolean
    doc: input is SAM
    inputBinding:
      position: 102
      prefix: --is_sam
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
stdout: bamkit_bamcleanheader.py.out
