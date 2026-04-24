cwlVersion: v1.2
class: CommandLineTool
baseCommand: predstoseq.py
label: plncpro_predtoseq
doc: "Use this to extract lncRNA or mRNA sequences, as predicted by PLNCPRO, from
  the input fasta file\n\nTool homepage: https://github.com/urmi-21/PLncPRO"
inputs:
  - id: max_length
    type:
      - 'null'
      - int
    doc: max_length
    inputBinding:
      position: 1
  - id: class_prob_cutoff
    type:
      - 'null'
      - float
    doc: class_prob_cutoff[range 0-1]
    inputBinding:
      position: 102
      prefix: -s
  - id: input_fastafile
    type: File
    doc: input fastafile
    inputBinding:
      position: 102
      prefix: -f
  - id: min_length
    type:
      - 'null'
      - int
    doc: min_length
    inputBinding:
      position: 102
      prefix: -m
  - id: predictionfile
    type: File
    doc: predictionfile
    inputBinding:
      position: 102
      prefix: -p
  - id: required_label
    type:
      - 'null'
      - string
    doc: required label
    inputBinding:
      position: 102
      prefix: -l
outputs:
  - id: outputfile
    type: File
    doc: outputfile
    outputBinding:
      glob: $(inputs.outputfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plncpro:1.2.2--py37hc9558a2_0
