cwlVersion: v1.2
class: CommandLineTool
baseCommand: traitar_show
label: traitar_show
doc: "show features important for classification\n\nTool homepage: http://github.com/aweimann/traitar"
inputs:
  - id: phenotype
    type: string
    doc: phenotype under investigation
    inputBinding:
      position: 1
  - id: include_negative
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --include_negative
  - id: models_f
    type:
      - 'null'
      - File
    doc: phenotype models archive; if set look for the target in the phenotype 
      in thegiven phenotype collection
    inputBinding:
      position: 102
      prefix: --models_f
  - id: predictor
    type:
      - 'null'
      - string
    doc: pick phypat or phypat+PGL classifier
    inputBinding:
      position: 102
      prefix: --predictor
  - id: strategy
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --strategy
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
stdout: traitar_show.out
