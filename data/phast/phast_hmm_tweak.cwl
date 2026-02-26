cwlVersion: v1.2
class: CommandLineTool
baseCommand: phast_hmm_tweak
label: phast_hmm_tweak
doc: "Adjusts parameters of a HMM to better fit a set of sequences.\n\nTool homepage:
  http://compgen.cshl.edu/phast/"
inputs:
  - id: hmm_file
    type: File
    doc: Input HMM file
    inputBinding:
      position: 1
  - id: seq_file
    type: File
    doc: Input sequence file (e.g., FASTA, PHYLIP)
    inputBinding:
      position: 2
  - id: iterations
    type:
      - 'null'
      - int
    doc: 'Number of EM iterations (default: 10)'
    default: 10
    inputBinding:
      position: 103
      prefix: --iterations
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: 'Learning rate for gradient descent (default: 0.01)'
    default: 0.01
    inputBinding:
      position: 103
      prefix: --learning-rate
  - id: tolerance
    type:
      - 'null'
      - float
    doc: 'Convergence tolerance (default: 1e-4)'
    default: 0.0001
    inputBinding:
      position: 103
      prefix: --tolerance
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_hmm_file
    type:
      - 'null'
      - File
    doc: 'Output HMM file (default: overwrite input)'
    outputBinding:
      glob: $(inputs.output_hmm_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
