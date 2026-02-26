cwlVersion: v1.2
class: CommandLineTool
baseCommand: profbval
label: profbval
doc: Predicts flexible and rigid residues from sequence (B-value predictor).
inputs:
  - id: fasta_file
    type: File
    doc: Input protein sequence file in FASTA format.
    inputBinding:
      position: 1
  - id: rdb_file
    type: File
    doc: Input RDB format file (typically output from PROFphd).
    inputBinding:
      position: 2
  - id: window
    type:
      - 'null'
      - int
    doc: Smoothing window size.
    default: 9
    inputBinding:
      position: 3
  - id: method
    type:
      - 'null'
      - int
    doc: Prediction method/mode to use.
    default: 1
    inputBinding:
      position: 4
outputs:
  - id: output_file
    type: File
    doc: Path to the output file where predictions will be written.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/profbval:v1.0.22-6-deb_cv1
