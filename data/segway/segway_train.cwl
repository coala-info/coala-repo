cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - segway
  - train
label: segway_train
doc: "Train a Segway model.\n\nTool homepage: http://segway.hoffmanlab.org/"
inputs:
  - id: genomedata
    type: string
    doc: Genomic data to train on
    inputBinding:
      position: 1
  - id: traindir
    type: Directory
    doc: Directory to save training artifacts
    inputBinding:
      position: 2
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: Delete any preexisting files and assumes any model filesspecified in 
      options as output to be overwritten
    inputBinding:
      position: 103
      prefix: --clobber
  - id: distribution
    type:
      - 'null'
      - string
    doc: Use DIST distribution
    inputBinding:
      position: 103
      prefix: --distribution
  - id: dont_train
    type:
      - 'null'
      - File
    doc: Use FILE as list of parameters not to train
    inputBinding:
      position: 103
      prefix: --dont-train
  - id: exclude_coords
    type:
      - 'null'
      - File
    doc: Filter out genomic coordinates in FILE
    inputBinding:
      position: 103
      prefix: --exclude-coords
  - id: include_coords
    type:
      - 'null'
      - File
    doc: Limit to genomic coordinates in FILE
    inputBinding:
      position: 103
      prefix: --include-coords
  - id: input_master
    type:
      - 'null'
      - File
    doc: Use or create input master in FILE
    inputBinding:
      position: 103
      prefix: --input-master
  - id: max_train_rounds
    type:
      - 'null'
      - int
    doc: Each training instance runs a maximum of NUM rounds
    inputBinding:
      position: 103
      prefix: --max-train-rounds
  - id: minibatch_fraction
    type:
      - 'null'
      - float
    doc: Use a random fraction FRAC positions for each EM iteration
    inputBinding:
      position: 103
      prefix: --minibatch-fraction
  - id: mixture_components
    type:
      - 'null'
      - int
    doc: Number of Gaussian mixture components
    inputBinding:
      position: 103
      prefix: --mixture-components
  - id: num_instances
    type:
      - 'null'
      - int
    doc: Run NUM training instances, randomizing start parameters NUM times
    inputBinding:
      position: 103
      prefix: --num-instances
  - id: num_labels
    type:
      - 'null'
      - int
    doc: Make SLICE segment labels
    inputBinding:
      position: 103
      prefix: --num-labels
  - id: num_sublabels
    type:
      - 'null'
      - int
    doc: Make NUM segment sublabels
    inputBinding:
      position: 103
      prefix: --num-sublabels
  - id: observations
    type:
      - 'null'
      - Directory
    doc: DEPRECATED - temp files are now used and recommended. Previously would 
      use or create observations in DIR
    inputBinding:
      position: 103
      prefix: --observations
  - id: prior_strength
    type:
      - 'null'
      - float
    doc: Use RATIO times the number of data counts as the number of pseudocounts
      for the segment length prior
    inputBinding:
      position: 103
      prefix: --prior-strength
  - id: recover
    type:
      - 'null'
      - Directory
    doc: Continue from interrupted run in DIR
    inputBinding:
      position: 103
      prefix: --recover
  - id: resolution
    type:
      - 'null'
      - int
    doc: Downsample to every RES bp
    inputBinding:
      position: 103
      prefix: --resolution
  - id: reverse_world
    type:
      - 'null'
      - int
    doc: Reverse sequences in concatenated world (0-based)
    inputBinding:
      position: 103
      prefix: --reverse-world
  - id: ruler_scale
    type:
      - 'null'
      - float
    doc: Ruler marking every SCALE bp
    inputBinding:
      position: 103
      prefix: --ruler-scale
  - id: seg_table
    type:
      - 'null'
      - File
    doc: Load segment hyperparameters from FILE
    inputBinding:
      position: 103
      prefix: --seg-table
  - id: segtransition_weight_scale
    type:
      - 'null'
      - float
    doc: Exponent for segment transition probability
    inputBinding:
      position: 103
      prefix: --segtransition-weight-scale
  - id: semisupervised
    type:
      - 'null'
      - File
    doc: Semisupervised segmentation with labels in FILE
    inputBinding:
      position: 103
      prefix: --semisupervised
  - id: structure
    type:
      - 'null'
      - File
    doc: Use or create structure in FILE
    inputBinding:
      position: 103
      prefix: --structure
  - id: track
    type:
      - 'null'
      - type: array
        items: string
    doc: Append track to list of tracks to use
    inputBinding:
      position: 103
      prefix: --track
  - id: track_weight
    type:
      - 'null'
      - float
    doc: Exponent for all input track probabilities
    inputBinding:
      position: 103
      prefix: --track-weight
  - id: tracks_from_file
    type:
      - 'null'
      - File
    doc: Append tracks from newline-delimited FILE to list of tracks to use
    inputBinding:
      position: 103
      prefix: --tracks-from
  - id: trainable_params
    type:
      - 'null'
      - File
    doc: Use or create trainable parameters in FILE
    inputBinding:
      position: 103
      prefix: --trainable-params
  - id: validation_coords
    type:
      - 'null'
      - File
    doc: Use genomic coordinates in FILE as a validation set
    inputBinding:
      position: 103
      prefix: --validation-coords
  - id: validation_fraction
    type:
      - 'null'
      - float
    doc: Use a random held out set of size FRAC of the included genomic regions 
      to validate the parameters learned by each training round
    inputBinding:
      position: 103
      prefix: --validation-fraction
  - id: var_floor
    type:
      - 'null'
      - float
    doc: Sets the variance floor
    inputBinding:
      position: 103
      prefix: --var-floor
  - id: virtual_evidence
    type:
      - 'null'
      - File
    doc: Virtual evidence with priors for labels at each position in FILE
    inputBinding:
      position: 103
      prefix: --virtual-evidence
  - id: virtual_evidence_weight
    type:
      - 'null'
      - float
    doc: Exponent for virtual evidence probability
    inputBinding:
      position: 103
      prefix: --virtual-evidence-weight
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segway:3.0.4--pyh7cba7a3_1
stdout: segway_train.out
