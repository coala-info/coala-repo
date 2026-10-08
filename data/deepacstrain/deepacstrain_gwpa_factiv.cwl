cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
  - gwpa
  - factiv
label: deepacstrain_gwpa_factiv
doc: "Get filter activations.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
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
  - id: test_fasta
    type: File
    doc: "Reads of the test data set (.fasta)"
    inputBinding:
      position: 101
      prefix: --test-fasta
  - id: out_dir
    type: string
    doc: "Output directory"
    default: "factiv"
    inputBinding:
      position: 101
      prefix: --out-dir
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
  - id: inter_neuron
    type:
      - 'null'
      - type: array
        items: int
    doc: "Perform calculations for this filter only"
    inputBinding:
      position: 101
      prefix: --inter-neuron
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
