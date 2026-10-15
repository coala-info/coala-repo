cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_genetrees_split_models_from_genetrees
label: phyluce_phyluce_genetrees_split_models_from_genetrees
doc: "Split the substitution models from genetrees output by CloudForest\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: genetrees
    type: File
    doc: "The cloudforest genetree file containing models"
    inputBinding:
      position: 1
      prefix: --genetrees
  - id: output
    type: string
    doc: "The output file to hold the parsed substitution model data"
    inputBinding:
      position: 2
      prefix: --output
outputs:
  - id: models
    type: File
    doc: "Tab-separated locus and substitution model (AICc-<model>) table."
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
