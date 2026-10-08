cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
  - explain
  - maxact
label: deepacstrain_explain_maxact
doc: "Get DeepBind-like max-activation scores.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: model
    type: File
    doc: "Model file (.h5)"
    inputBinding:
      position: 101
      prefix: --model
  - id: test_data
    type: File
    doc: "Test data (.npy)"
    inputBinding:
      position: 101
      prefix: --test-data
  - id: nonpatho_test
    type: File
    doc: "Nonpathogenic reads of the test data set (.fasta)"
    inputBinding:
      position: 101
      prefix: --nonpatho-test
  - id: patho_test
    type: File
    doc: "Pathogenic reads of the test data set (.fasta)"
    inputBinding:
      position: 101
      prefix: --patho-test
  - id: out_dir
    type: string
    doc: "Output directory"
    default: "maxact"
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: n_cpus
    type:
      - 'null'
      - int
    doc: "Number of CPU cores. Default: all."
    inputBinding:
      position: 101
      prefix: --n-cpus
  - id: recurrent
    type:
      - 'null'
      - boolean
    doc: "Interpret elements of the LSTM output"
    inputBinding:
      position: 101
      prefix: --recurrent
  - id: inter_layer
    type:
      - 'null'
      - int
    doc: "Perform calculations for this intermediate layer"
    inputBinding:
      position: 101
      prefix: --inter-layer
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: "Sequence chunk size. Decrease for lower memory usage."
    inputBinding:
      position: 101
      prefix: --seq-chunk
outputs:
  - id: out
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepacstrain:0.2.1--py_0
