cwlVersion: v1.2
class: CommandLineTool
baseCommand: train_seqstructhmm
label: sshmm_train_seqstructhmm
doc: "Trains a Hidden Markov Model for the sequence-structure binding preferences
  of an RNA-binding protein. The model is trained on sequences and structures from
  a CLIP-seq experiment given in two FASTA-like files.\nDuring the training process,
  statistics about the model are printed on stdout. In every iteration, the current
  model and a visualization of the model can be stored in the output directory.\n\
  The training process terminates when no significant progress has been made for three
  iterations.\n\nTool homepage: https://github.molgen.mpg.de/heller/ssHMM"
inputs:
  - id: training_sequences
    type: File
    doc: FASTA file with sequences for training
    inputBinding:
      position: 1
  - id: training_structures
    type: File
    doc: FASTA file with RNA structures for training
    inputBinding:
      position: 2
  - id: block_size
    type:
      - 'null'
      - int
    doc: number of sequences to be held-out in each iteration
    inputBinding:
      position: 103
      prefix: --block_size
  - id: flexibility
    type:
      - 'null'
      - int
    doc: 'greedyness of Gibbs sampler: model parameters are sampled from among the
      top f configurations (default: f=10), set f to 0 in order to include all possible
      configurations'
    inputBinding:
      position: 103
      prefix: --flexibility
  - id: job_name
    type:
      - 'null'
      - string
    doc: name of the job
    inputBinding:
      position: 103
      prefix: --job_name
  - id: motif_length
    type:
      - 'null'
      - int
    doc: length of the motif that shall be found
    inputBinding:
      position: 103
      prefix: --motif_length
  - id: no_model_state
    type:
      - 'null'
      - boolean
    doc: do not write model state every i iterations
    inputBinding:
      position: 103
      prefix: --no_model_state
  - id: only_best_shape
    type:
      - 'null'
      - boolean
    doc: train only using best structure for each sequence
    inputBinding:
      position: 103
      prefix: --only_best_shape
  - id: random
    type:
      - 'null'
      - boolean
    doc: Initialize the model randomly
    inputBinding:
      position: 103
      prefix: --random
  - id: termination_interval
    type:
      - 'null'
      - int
    doc: produce output every <i> iterations
    inputBinding:
      position: 103
      prefix: --termination_interval
  - id: threshold
    type:
      - 'null'
      - float
    doc: the iterative algorithm is terminated if this reduction in sequence 
      structure loglikelihood is not reached for any of the 3 last measurements
    inputBinding:
      position: 103
      prefix: --threshold
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: directory to write output files to
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sshmm:1.0.7--py27_0
