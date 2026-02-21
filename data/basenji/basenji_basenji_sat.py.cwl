cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenji_sat.py
label: basenji_basenji_sat.py
doc: "Compute saturation mutagenesis scores for sequences in an HDF5 file using a
  trained Basenji model.\n\nTool homepage: https://github.com/calico/basenji"
inputs:
  - id: params_file
    type: File
    doc: JSON file containing model hyperparameters
    inputBinding:
      position: 1
  - id: model_file
    type: File
    doc: Trained model weights file
    inputBinding:
      position: 2
  - id: h5_file
    type: File
    doc: HDF5 file containing sequences and targets
    inputBinding:
      position: 3
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: Genome FASTA for sequence context
    inputBinding:
      position: 104
      prefix: --genome_fasta
  - id: min_activity
    type:
      - 'null'
      - float
    doc: Minimum activity filter for sequences
    inputBinding:
      position: 104
      prefix: --min_activity
  - id: num_seqs
    type:
      - 'null'
      - int
    doc: Number of sequences to process
    inputBinding:
      position: 104
      prefix: --num_seqs
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of parallel processes
    inputBinding:
      position: 104
      prefix: --processes
  - id: sat_mut_len
    type:
      - 'null'
      - int
    doc: Length of sequence to perform saturation mutagenesis on
    inputBinding:
      position: 104
      prefix: --sat_mut_len
  - id: targets
    type:
      - 'null'
      - string
    doc: Comma-separated list of target indexes to process
    inputBinding:
      position: 104
      prefix: --targets
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for results
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
