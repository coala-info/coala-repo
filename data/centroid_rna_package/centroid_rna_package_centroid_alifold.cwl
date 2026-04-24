cwlVersion: v1.2
class: CommandLineTool
baseCommand: centroid_alifold
label: centroid_rna_package_centroid_alifold
doc: "CentroidAlifold v0.0.16 for predicting common RNA secondary structures\n\nTool
  homepage: https://github.com/satoken/centroid-rna-package"
inputs:
  - id: seq
    type: string
    doc: Input sequence
    inputBinding:
      position: 1
  - id: bp_matrix
    type:
      - 'null'
      - type: array
        items: File
    doc: Optional base pair matrices
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
  - id: ea
    type:
      - 'null'
      - string
    doc: 'compute (pseudo-)expected accuracy (pseudo if arg==0, sampling if arg>0;
      arg: # of sampling)'
    inputBinding:
      position: 103
      prefix: --ea
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
      - int
    doc: the maximum distance of base-pairs
    inputBinding:
      position: 103
      prefix: --max-dist
  - id: max_mcc
    type:
      - 'null'
      - string
    doc: 'predict secondary structure by maximizing pseudo-expected MCC (arg: # of
      sampling)'
    inputBinding:
      position: 103
      prefix: --max-mcc
  - id: mea
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
  - id: params
    type:
      - 'null'
      - string
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
      - boolean
    doc: draw predicted secondary structures with the postscript (PS) format
    inputBinding:
      position: 103
      prefix: --postscript
  - id: sampling
    type:
      - 'null'
      - int
    doc: specify the number of samples to be generated for each sequence
    inputBinding:
      position: 103
      prefix: --sampling
  - id: seed
    type:
      - 'null'
      - int
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
  - id: output
    type:
      - 'null'
      - File
    doc: specify filename to output predicted secondary structures. If empty, 
      use the standard output.
    outputBinding:
      glob: $(inputs.output)
  - id: posteriors_output
    type:
      - 'null'
      - File
    doc: specify filename to output base-pairing probability matrices. If empty,
      use the standard output.
    outputBinding:
      glob: $(inputs.posteriors_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centroid_rna_package:0.0.16--0
