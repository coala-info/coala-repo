cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plncpro
  - predtoseq
label: plncpro_predtoseq
doc: "Extract lncRNA or mRNA sequences, as predicted by PLNCPRO, from the input fasta file\n\nTool homepage: https://github.com/urmi-21/PLncPRO"
inputs:
  - id: input_fastafile
    type: File
    doc: 'Input fasta file'
    inputBinding:
      position: 101
      prefix: -f
  - id: output_file
    type: string
    doc: 'Output file'
    inputBinding:
      position: 101
      prefix: -o
  - id: predictionfile
    type: File
    doc: 'PLNCPRO prediction file'
    inputBinding:
      position: 101
      prefix: -p
  - id: required_label
    type:
      - 'null'
      - string
    doc: 'Required label [default: 0]'
    inputBinding:
      position: 101
      prefix: -l
  - id: class_prob_cutoff
    type:
      - 'null'
      - float
    doc: 'Class probability cutoff, range 0-1 [default: 0]'
    inputBinding:
      position: 101
      prefix: -s
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'Minimum sequence length [default 0] (the help text shows -m, but the program only accepts --min)'
    inputBinding:
      position: 101
      prefix: --min
  - id: max_length
    type:
      - 'null'
      - int
    doc: 'Maximum sequence length [default inf] (the help text shows a second value after -m, but the program only accepts --max)'
    inputBinding:
      position: 101
      prefix: --max
outputs:
  - id: output
    type: File
    doc: 'Extracted sequences'
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plncpro:1.2.2--py37hc9558a2_0
