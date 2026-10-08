cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
  - explain
  - fcontribs
label: deepacstrain_explain_fcontribs
doc: "Get DeepLIFT/SHAP filter contribution scores.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: model
    type: File
    doc: "Model file (.h5)"
    inputBinding:
      position: 101
      prefix: --model
  - id: w_norm
    type:
      - 'null'
      - boolean
    doc: "Set flag if filter weight matrices should be mean-centered"
    inputBinding:
      position: 101
      prefix: --w-norm
  - id: test_data
    type: File
    doc: "Test data (.npy)"
    inputBinding:
      position: 101
      prefix: --test_data
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
    default: "fcontribs"
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: ref_mode
    type:
      - 'null'
      - type: enum
        symbols:
          - "N"
          - "GC"
          - "own_ref_file"
    doc: "Modus to calculate reference sequences"
    inputBinding:
      position: 101
      prefix: --ref-mode
  - id: train_data
    type:
      - 'null'
      - File
    doc: "Train data (.npy), necessary to calculate reference sequences if ref_mode is 'GC'"
    inputBinding:
      position: 101
      prefix: --train-data
  - id: ref_seqs
    type:
      - 'null'
      - File
    doc: "User provided reference sequences (.fasta) if ref_mode is 'own_ref_file'"
    inputBinding:
      position: 101
      prefix: --ref-seqs
  - id: inter_neuron
    type:
      - 'null'
      - type: array
        items: int
    doc: "Perform calculations for this intermediate neuron only"
    inputBinding:
      position: 101
      prefix: --inter-neuron
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
  - id: all_occurrences
    type:
      - 'null'
      - boolean
    doc: "Extract contributions for all occurrences of a filter per read (Default: max only)"
    inputBinding:
      position: 101
      prefix: --all-occurrences
  - id: recurrent
    type:
      - 'null'
      - boolean
    doc: "Interpret elements of the LSTM output"
    inputBinding:
      position: 101
      prefix: --recurrent
  - id: no_check
    type:
      - 'null'
      - boolean
    doc: "Disable additivity check."
    inputBinding:
      position: 101
      prefix: --no-check
  - id: partial
    type:
      - 'null'
      - boolean
    doc: "Calculate partial nucleotide contributions per filter."
    inputBinding:
      position: 101
      prefix: --partial
  - id: easy_partial
    type:
      - 'null'
      - boolean
    doc: "Calculate easy partial nucleotide contributions per filter. Works for the first convolutional layer only; disables all-occurences mode."
    inputBinding:
      position: 101
      prefix: --easy-partial
outputs:
  - id: out
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.out_dir)
  - id: w_norm_model
    type:
      - 'null'
      - File
    doc: Model with mean-centered filter weights (<model>_w_norm.h5), written
      beside the model when --w-norm is set
    outputBinding:
      glob: $(inputs.model.nameroot)_w_norm.h5
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.model)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepacstrain:0.2.1--py_0
