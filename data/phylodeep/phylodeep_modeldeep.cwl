cwlVersion: v1.2
class: CommandLineTool
baseCommand: modeldeep
label: phylodeep_modeldeep
doc: "Model selection for phylodynamics using pretrained neural networks.\n\nTool
  homepage: https://github.com/evolbioinfo/phylodeep"
inputs:
  - id: proba_sampling
    type: float
    doc: presumed sampling probability for removed tips. Must be between 0.01 
      and 1
    inputBinding:
      position: 101
      prefix: --proba_sampling
  - id: tree_file
    type: File
    doc: input tree in newick format (must be rooted, without polytomies and 
      containing at least 50 tips).
    inputBinding:
      position: 101
      prefix: --tree_file
  - id: vector_representation
    type:
      - 'null'
      - string
    doc: 'Choose a type of tree representation and neural networks. You can choose
      either CNN_FULL_TREE: CNN trained on full tree representation or FFNN_SUMSTATS:
      FFNN trained on summary statistics. By default set to CNN_FULL_TREE.'
    inputBinding:
      position: 101
      prefix: --vector_representation
outputs:
  - id: output
    type: File
    doc: The name of the output csv file (comma-separated) containing predicted 
      probabilities of each model.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylodeep:0.9--pyhdfd78af_0
