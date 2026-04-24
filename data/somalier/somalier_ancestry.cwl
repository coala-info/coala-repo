cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - somalier
  - pca
label: somalier_ancestry
doc: "dimensionality reduction\n\nTool homepage: https://github.com/brentp/somalier"
inputs:
  - id: extracted_files
    type:
      - 'null'
      - type: array
        items: File
    doc: $sample.somalier files for each sample. place labelled samples first 
      followed by '++' then *.somalier for query samples
    inputBinding:
      position: 1
  - id: labels
    type:
      - 'null'
      - File
    doc: file with ancestry labels
    inputBinding:
      position: 102
      prefix: --labels
  - id: n_pcs
    type:
      - 'null'
      - int
    doc: number of principal components to use in the reduced dataset
    inputBinding:
      position: 102
      prefix: --n-pcs
  - id: nn_batch_size
    type:
      - 'null'
      - int
    doc: batch size fo training neural network
    inputBinding:
      position: 102
      prefix: --nn-batch-size
  - id: nn_hidden_size
    type:
      - 'null'
      - int
    doc: shape of hidden layer in neural network
    inputBinding:
      position: 102
      prefix: --nn-hidden-size
  - id: nn_test_samples
    type:
      - 'null'
      - int
    doc: number of labeled samples to test for NN convergence
    inputBinding:
      position: 102
      prefix: --nn-test-samples
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: prefix for output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/somalier:0.3.1--hc78c8e0_0
