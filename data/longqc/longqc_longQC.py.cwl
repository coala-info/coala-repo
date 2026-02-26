cwlVersion: v1.2
class: CommandLineTool
baseCommand: longQC.py
label: longqc_longQC.py
doc: "longQC.py: A tool for quality control of long sequencing reads.\n\nTool homepage:
  https://github.com/yfukasawa/LongQC"
inputs:
  - id: options
    type:
      - 'null'
      - string
    doc: Additional options for longQC.py
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longqc:1.2.0c--hdfd78af_0
stdout: longqc_longQC.py.out
