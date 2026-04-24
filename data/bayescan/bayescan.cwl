cwlVersion: v1.2
class: CommandLineTool
baseCommand: bayescan
label: bayescan
doc: "BayeScan is a tool for detecting natural selection from population genetic data
  using Bayesian model selection.\n\nTool homepage: https://github.com/mfoll/BayeScan"
inputs:
  - id: input_file
    type: File
    doc: Input data file
    inputBinding:
      position: 1
  - id: all_posterior
    type:
      - 'null'
      - boolean
    doc: Output all posterior probabilities (default is only those > 0.1)
    inputBinding:
      position: 102
      prefix: -allp
  - id: burn_in
    type:
      - 'null'
      - int
    doc: Burn-in length
    inputBinding:
      position: 102
      prefix: -burn
  - id: discard_loci
    type:
      - 'null'
      - File
    doc: Optional file containing a list of loci to discard
    inputBinding:
      position: 102
      prefix: -d
  - id: include_loci
    type:
      - 'null'
      - File
    doc: Optional file containing a list of loci to include
    inputBinding:
      position: 102
      prefix: -f
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of iterations
    inputBinding:
      position: 102
      prefix: -n
  - id: nb_pilot_runs
    type:
      - 'null'
      - int
    doc: Number of pilot runs
    inputBinding:
      position: 102
      prefix: -nbp
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output file prefix, default is input file name
    inputBinding:
      position: 102
      prefix: -o
  - id: pilot_length
    type:
      - 'null'
      - int
    doc: Length of pilot runs
    inputBinding:
      position: 102
      prefix: -pilot
  - id: prior_odds
    type:
      - 'null'
      - float
    doc: Prior odds for the neutral model
    inputBinding:
      position: 102
      prefix: -pr_odds
  - id: thinning_interval
    type:
      - 'null'
      - int
    doc: Thinning interval
    inputBinding:
      position: 102
      prefix: -thin
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads, default is number of processors
    inputBinding:
      position: 102
      prefix: -threads
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory, default is current directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayescan:2.0.1--h9948957_7
