cwlVersion: v1.2
class: CommandLineTool
baseCommand: freec
label: control-freec_freec
doc: "a method for automatic detection of copy number alterations, subclones and for
  accurate estimation of contamination and main ploidy using deep-sequencing data\n\
  \nTool homepage: https://github.com/BoevaLab/FREEC"
inputs:
  - id: config_file
    type: File
    doc: config file
    inputBinding:
      position: 101
      prefix: -conf
  - id: control
    type:
      - 'null'
      - File
    doc: Control BAM file
    inputBinding:
      position: 101
      prefix: -control
  - id: sample
    type:
      - 'null'
      - File
    doc: Sample BAM file
    inputBinding:
      position: 101
      prefix: -sample
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/control-freec:11.6--hdbdd923_3
stdout: control-freec_freec.out
