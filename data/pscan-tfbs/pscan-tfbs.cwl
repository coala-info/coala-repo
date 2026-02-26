cwlVersion: v1.2
class: CommandLineTool
baseCommand: pscan-tfbs
label: pscan-tfbs
doc: Predict transcription factor binding sites
inputs:
  - id: input_sequence
    type: File
    doc: Input DNA sequence file (FASTA format)
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: Output directory for results
    inputBinding:
      position: 2
  - id: matrix_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory containing PWM matrices (default: internal matrices)'
    inputBinding:
      position: 103
      prefix: --matrix-dir
  - id: min_distance
    type:
      - 'null'
      - int
    doc: 'Minimum distance between predicted binding sites (default: 10)'
    inputBinding:
      position: 103
      prefix: --min-distance
  - id: strand
    type:
      - 'null'
      - string
    doc: "Strand to analyze ('+' or '-' or 'both', default: 'both')"
    inputBinding:
      position: 103
      prefix: --strand
  - id: threshold
    type:
      - 'null'
      - float
    doc: 'Minimum score threshold for predicting a binding site (default: 0.85)'
    inputBinding:
      position: 103
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pscan-tfbs:v1.2.2-3-deb_cv1
stdout: pscan-tfbs.out
