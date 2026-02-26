cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamlibs.py
label: bamkit_bamlibs.py
doc: "output comma delimited string of read group IDs for each library\n\nTool homepage:
  https://github.com/hall-lab/bamkit"
inputs:
  - id: input
    type:
      - 'null'
      - File
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
stdout: bamkit_bamlibs.py.out
