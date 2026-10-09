cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmlogo
label: hmmer_hmmlogo
doc: "given an hmm, produce data required to build an hmm logo\n\nTool homepage: http://hmmer.org/"
inputs:
  - id: hmmfile
    type: File
    doc: Input profile HMM file
    inputBinding:
      position: 201
  - id: height_relent_all
    type:
      - 'null'
      - boolean
    doc: 'total height = relative entropy ; all letters shown (default)'
    inputBinding:
      position: 103
      prefix: '--height_relent_all'
  - id: height_relent_abovebg
    type:
      - 'null'
      - boolean
    doc: 'total height = relative entropy ; only letters >bg shown'
    inputBinding:
      position: 103
      prefix: '--height_relent_abovebg'
  - id: height_score
    type:
      - 'null'
      - boolean
    doc: 'total height = sums of (pos|neg) scores; residue height = score'
    inputBinding:
      position: 103
      prefix: '--height_score'
  - id: no_indel
    type:
      - 'null'
      - boolean
    doc: "don't provide indel rate values"
    inputBinding:
      position: 103
      prefix: '--no_indel'
outputs:
  - id: logo_data
    type: stdout
    doc: Per-position residue heights (and indel rates) for building an HMM logo
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
stdout: hmmer_hmmlogo.out
