cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenji_motifs.py
label: basenji_basenji_motifs.py
doc: "Analyze and visualize motifs identified by a trained Basenji model.\n\nTool
  homepage: https://github.com/calico/basenji"
inputs:
  - id: params_file
    type: File
    doc: JSON file with model hyperparameters
    inputBinding:
      position: 1
  - id: model_file
    type: File
    doc: Trained model file
    inputBinding:
      position: 2
  - id: data_h5_file
    type: File
    doc: HDF5 file containing the sequences and targets
    inputBinding:
      position: 3
  - id: index
    type:
      - 'null'
      - int
    doc: Target index to analyze
    inputBinding:
      position: 104
      prefix: --index
  - id: length
    type:
      - 'null'
      - int
    doc: Window length to analyze
    inputBinding:
      position: 104
      prefix: --length
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes
    inputBinding:
      position: 104
      prefix: --processes
  - id: sample
    type:
      - 'null'
      - int
    doc: Number of sequences to sample
    inputBinding:
      position: 104
      prefix: --sample
  - id: threshold
    type:
      - 'null'
      - float
    doc: Motif threshold
    inputBinding:
      position: 104
      prefix: --threshold
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
