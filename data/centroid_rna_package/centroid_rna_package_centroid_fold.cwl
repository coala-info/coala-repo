cwlVersion: v1.2
class: CommandLineTool
baseCommand: centroid_fold
label: centroid_rna_package_centroid_fold
doc: "CentroidFold v0.0.16 for predicting RNA secondary structures\n\nTool homepage:
  https://github.com/satoken/centroid-rna-package"
inputs:
  - id: sequence
    type: string
    doc: Input sequence
    inputBinding:
      position: 1
  - id: bp_matrix
    type:
      - 'null'
      - type: array
        items: File
    doc: Base pairing matrix file(s)
    inputBinding:
      position: 2
  - id: constraints
    type:
      - 'null'
      - boolean
    doc: use structure constraints
    inputBinding:
      position: 103
      prefix: --constraints
  - id: engine
    type:
      - 'null'
      - string
    doc: specify the inference engine
    inputBinding:
      position: 103
      prefix: --engine
  - id: gamma
    type:
      - 'null'
      - string
    doc: weight of base pairs
    inputBinding:
      position: 103
      prefix: --gamma
  - id: max_clusters
    type:
      - 'null'
      - int
    doc: the maximum number of clusters for the stochastic sampling algorithm
    inputBinding:
      position: 103
      prefix: --max-clusters
  - id: max_dist
    type:
      - 'null'
      - string
    doc: the maximum distance of base-pairs
    inputBinding:
      position: 103
      prefix: --max-dist
  - id: max_mcc_sampling
    type:
      - 'null'
      - string
    doc: 'predict secondary structure by maximizing pseudo-expected MCC (arg: # of
      sampling)'
    inputBinding:
      position: 103
      prefix: --max-mcc
  - id: mea_estimator
    type:
      - 'null'
      - boolean
    doc: run as an MEA estimator
    inputBinding:
      position: 103
      prefix: --mea
  - id: mixture
    type:
      - 'null'
      - string
    doc: mixture weights of inference engines
    inputBinding:
      position: 103
      prefix: --mixture
  - id: noncanonical
    type:
      - 'null'
      - boolean
    doc: allow non-canonical base-pairs
    inputBinding:
      position: 103
      prefix: --noncanonical
  - id: num_samples
    type:
      - 'null'
      - string
    doc: specify the number of samples to be generated for each sequence
    inputBinding:
      position: 103
      prefix: --sampling
  - id: params_file
    type:
      - 'null'
      - File
    doc: use the parameter file
    inputBinding:
      position: 103
      prefix: --params
  - id: posteriors
    type:
      - 'null'
      - string
    doc: output base-pairing probability matrices which contain base-pairing 
      probabilities more than the given value.
    inputBinding:
      position: 103
      prefix: --posteriors
  - id: postscript
    type:
      - 'null'
      - string
    doc: draw predicted secondary structures with the postscript (PS) format
    inputBinding:
      position: 103
      prefix: --postscript
  - id: pseudo_expected_accuracy
    type:
      - 'null'
      - string
    doc: 'compute (pseudo-)expected accuracy (pseudo if arg==0, sampling if arg>0;
      arg: # of sampling)'
    inputBinding:
      position: 103
      prefix: --ea
  - id: seed
    type:
      - 'null'
      - string
    doc: specify the seed for the random number generator (set this 
      automatically if seed=0)
    inputBinding:
      position: 103
      prefix: --seed
  - id: threshold
    type:
      - 'null'
      - string
    doc: thereshold of base pairs (this option overwrites 'gamma')
    inputBinding:
      position: 103
      prefix: --threshold
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: specify filename to output predicted secondary structures. If empty, 
      use the standard output.
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_posteriors_file
    type:
      - 'null'
      - File
    doc: specify filename to output base-pairing probability matrices. If empty,
      use the standard output.
    outputBinding:
      glob: $(inputs.output_posteriors_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centroid_rna_package:0.0.16--0
