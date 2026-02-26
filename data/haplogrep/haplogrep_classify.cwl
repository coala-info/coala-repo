cwlVersion: v1.2
class: CommandLineTool
baseCommand: haplogrep_classify
label: haplogrep_classify
doc: "mtDNA Haplogroup Classifiction\n\nTool homepage: https://haplogrep.i-med.ac.at"
inputs:
  - id: classify
    type:
      - 'null'
      - boolean
    doc: Run classification
    inputBinding:
      position: 101
      prefix: classify
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplogrep:2.4.0--hdfd78af_0
stdout: haplogrep_classify.out
