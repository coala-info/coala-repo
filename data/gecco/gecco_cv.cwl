cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gecco
  - cv
label: gecco_cv
doc: "Cross-validation for gecco\n\nTool homepage: https://gecco.embl.de/"
inputs:
  - id: c1
    type:
      - 'null'
      - float
    doc: The strength of the L1 regularization.
    default: 0.15
    inputBinding:
      position: 101
      prefix: --c1
  - id: c2
    type:
      - 'null'
      - float
    doc: The strength of the L2 regularization.
    default: 0.15
    inputBinding:
      position: 101
      prefix: --c2
  - id: clusters
    type: File
    doc: The path to a cluster annotation table, used to extract the domain 
      composition for the type classifier.
    default: None
    inputBinding:
      position: 101
      prefix: --clusters
  - id: correction
    type:
      - 'null'
      - string
    doc: The multiple test correction method to use when computing significance 
      with multiple testing.
    default: None
    inputBinding:
      position: 101
      prefix: --correction
  - id: e_filter
    type:
      - 'null'
      - float
    doc: The e-value cutoff for protein domains to be included. This is not 
      stable across versions, so consider using a p-value filter instead.
    default: None
    inputBinding:
      position: 101
      prefix: --e-filter
  - id: feature_type
    type:
      - 'null'
      - string
    doc: The level at which the features should be extracted and given to the 
      CRF.
    default: protein
    inputBinding:
      position: 101
      prefix: --feature-type
  - id: features
    type: File
    doc: The path to a domain annotation table, used to train the CRF model.
    default: None
    inputBinding:
      position: 101
      prefix: --features
  - id: genes
    type: File
    doc: The path to a gene table, containing the coordinates of the genes 
      inside the training sequence.
    default: None
    inputBinding:
      position: 101
      prefix: --genes
  - id: jobs
    type:
      - 'null'
      - int
    doc: The number of jobs to use for multithreading. Use 0 to use all 
      available CPUs.
    default: 0
    inputBinding:
      position: 101
      prefix: --jobs
  - id: loto
    type:
      - 'null'
      - boolean
    doc: Use Leave-One-Type-Out (LOTO) cross-validation instead of K-folds 
      cross-validation.
    default: false
    inputBinding:
      position: 101
      prefix: --loto
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Disable the console color
    default: true
    inputBinding:
      position: 101
      prefix: --no-color
  - id: no_markup
    type:
      - 'null'
      - boolean
    doc: Disable the console markup
    default: true
    inputBinding:
      position: 101
      prefix: --no-markup
  - id: no_shuffle
    type:
      - 'null'
      - boolean
    doc: Disable shuffling the data before fitting the model.
    default: true
    inputBinding:
      position: 101
      prefix: --no-shuffle
  - id: p_filter
    type:
      - 'null'
      - float
    doc: The p-value cutoff for protein domains to be included.
    default: '1e-09'
    inputBinding:
      position: 101
      prefix: --p-filter
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Reduce or disable the console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: seed
    type:
      - 'null'
      - int
    doc: The seed to initialize the random number generator used for shuffling 
      operations.
    default: 42
    inputBinding:
      position: 101
      prefix: --seed
  - id: select
    type:
      - 'null'
      - string
    doc: The fraction of most significant features to select from the training 
      data prior to training the CRF.
    default: None
    inputBinding:
      position: 101
      prefix: --select
  - id: splits
    type:
      - 'null'
      - int
    doc: Number of folds for cross-validation (if running K-folds).
    default: 10
    inputBinding:
      position: 101
      prefix: --splits
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the console output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: The length of the sliding window for CRF predictions.
    default: 5
    inputBinding:
      position: 101
      prefix: --window-size
  - id: window_step
    type:
      - 'null'
      - int
    doc: The step of the sliding window for CRF predictions.
    default: 1
    inputBinding:
      position: 101
      prefix: --window-step
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The name of the output file where the cross-validation table will be 
      written.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gecco:0.10.2--pyhdfd78af_0
