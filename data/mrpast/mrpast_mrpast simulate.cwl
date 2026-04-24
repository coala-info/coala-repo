cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrpast simulate
label: mrpast_mrpast simulate
doc: "Simulate demographic histories using mr.py.\n\nTool homepage: https://aprilweilab.github.io/"
inputs:
  - id: model
    type: File
    doc: The input YAML file specifying the model
    inputBinding:
      position: 1
  - id: arg_prefix
    type: string
    doc: The prefix for the output tree-sequence files
    inputBinding:
      position: 2
  - id: debug_demo
    type:
      - 'null'
      - boolean
    doc: Output results from msprime demography debugger.
    inputBinding:
      position: 103
      prefix: --debug-demo
  - id: individuals
    type:
      - 'null'
      - int
    doc: Number of individuals per population.
    inputBinding:
      position: 103
      prefix: --individuals
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of jobs (threads) to use.
    inputBinding:
      position: 103
      prefix: --jobs
  - id: recomb_rate
    type:
      - 'null'
      - string
    doc: Rate of recombination, or filename/prefix for recombination map. A 
      prefix will match '<prefix>*.txt'.
    inputBinding:
      position: 103
      prefix: --recomb-rate
  - id: replicates
    type:
      - 'null'
      - int
    doc: Number of simulation replications to perform.
    inputBinding:
      position: 103
      prefix: --replicates
  - id: seed
    type:
      - 'null'
      - int
    doc: Set the random seed.
    inputBinding:
      position: 103
      prefix: --seed
  - id: seq_len
    type:
      - 'null'
      - int
    doc: Length of sequences in base-pairs.
    inputBinding:
      position: 103
      prefix: --seq-len
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output, including timing information.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrpast:0.2--py312h8f4af18_0
stdout: mrpast_mrpast simulate.out
