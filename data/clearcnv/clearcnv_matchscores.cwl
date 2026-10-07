cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clearCNV
  - matchscores
label: clearcnv_matchscores
doc: "Matchscore calculation script.\n\nTool homepage: https://github.com/bihealth/clear-cnv"
inputs:
  - id: panel
    type: string
    doc: "Name of the data set (or panel)"
    inputBinding:
      position: 101
      prefix: --panel
  - id: coverages
    type: File
    doc: "Coverages file in tsv format"
    inputBinding:
      position: 101
      prefix: --coverages
  - id: matchscores
    type: string
    doc: "Output matchscores.tsv file"
    inputBinding:
      position: 101
      prefix: --matchscores
  - id: expected_artefacts
    type:
      - 'null'
      - float
    doc: "Expected ratio of CNVs or artefacs in target fragment counts"
    inputBinding:
      position: 101
      prefix: --expected_artefacts
  - id: cores
    type:
      - 'null'
      - int
    doc: "Number of cpu cores used in parallel processing. Default: determined automatically."
    inputBinding:
      position: 101
      prefix: --cores
  - id: fast
    type:
      - 'null'
      - boolean
    doc: "If set, clearCNV will speed up matchscore calculation by taking only at most 2.000 targets per sample into account."
    inputBinding:
      position: 101
      prefix: --fast
outputs:
  - id: matchscores_tsv
    type: File
    doc: "Match scores table"
    outputBinding:
      glob: "$(inputs.matchscores)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
