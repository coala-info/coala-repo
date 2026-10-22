cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - somalier
  - ancestry
label: somalier_ancestry
doc: "Perform ancestry prediction (PCA and neural network) on query samples, given
  a set of labelled samples.\n\nTool homepage: https://github.com/brentp/somalier"
arguments:
  - position: 2
    valueFrom: ++
inputs:
  - id: extracted_files
    type:
      type: array
      items: File
    doc: $sample.somalier files of the labelled samples (placed before the '++'
      separator)
    inputBinding:
      position: 1
  - id: query_files
    type:
      type: array
      items: File
    doc: $sample.somalier files of the query samples (placed after the '++'
      separator)
    inputBinding:
      position: 3
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
  - id: output_prefix_path
    type: string
    default: somalier-ancestry
    doc: prefix for output files (default somalier-ancestry)
    inputBinding:
      position: 103
      prefix: --output-prefix
outputs:
  - id: output_prefix
    type:
      - 'null'
      - type: array
        items: File
    doc: prefix for output files
    outputBinding:
      glob: $(inputs.output_prefix_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/somalier:0.3.1--hc78c8e0_0
