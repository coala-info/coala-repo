cwlVersion: v1.2
class: CommandLineTool
baseCommand: paramdeep
label: phylodeep_paramdeep
doc: "Parameter inference for phylodynamics using pretrained neural networks.\n\n\
  Tool homepage: https://github.com/evolbioinfo/phylodeep"
inputs:
  - id: ci_computation
    type:
      - 'null'
      - boolean
    doc: By default (without --ci_computation option), paramdeep outputs a csv 
      file (comma-separated) with point estimates for each parameter. With 
      --ci_computation option turned on, paramdeep computes and outputs 95% 
      confidence intervals (2.5% and 97.5%) for each estimate using approximated
      parametric bootstrap.
    inputBinding:
      position: 101
      prefix: --ci_computation
  - id: model
    type: string
    doc: Choose one of the models to be for which you want to obtain parameter 
      estimates. For parameter inference, you can choose either BD (basic 
      birth-death with incomplete sampling) or BDEI (BD with exposed-infectious)
      for trees of size between 50 and 199 tips and BD, BDEI or BDSS (BD with 
      superspreading individuals) for trees of size >= 200 tips.
    inputBinding:
      position: 101
      prefix: --model
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
    doc: 'Choose neural networks: either CNN_FULL_TREE: CNN trained on full tree representation
      or FFNN_SUMSTATS: FFNN trained on summary statistics. By default set to CNN_FULL_TREE.'
    default: CNN_FULL_TREE
    inputBinding:
      position: 101
      prefix: --vector_representation
outputs:
  - id: output
    type: File
    doc: The name of the output file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylodeep:0.9--pyhdfd78af_0
