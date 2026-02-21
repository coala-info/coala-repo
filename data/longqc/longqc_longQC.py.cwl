cwlVersion: v1.2
class: CommandLineTool
baseCommand: longqc_longQC.py
label: longqc_longQC.py
doc: "LongQC is a tool for quality control of long-read sequencing data. (Note: The
  provided help text contains only system error messages and no usage information;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/yfukasawa/LongQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longqc:1.2.0c--hdfd78af_0
stdout: longqc_longQC.py.out
