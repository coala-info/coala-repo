cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastsimbac
label: fastsimbac
doc: "A fast simulator for sequences under the coalescent with recombination. It is
  a program for simulating DNA sequences evolved under a variety of models, including
  population structure, variable population size, and recombination.\n\nTool homepage:
  https://bitbucket.org/nicofmay/fastsimbac/"
inputs:
  - id: nsam
    type: int
    doc: Number of samples to simulate
    inputBinding:
      position: 1
  - id: nreps
    type: int
    doc: Number of independent replications
    inputBinding:
      position: 2
  - id: output_haplotypes
    type:
      - 'null'
      - boolean
    doc: Output the haplotypes
    inputBinding:
      position: 103
      prefix: -H
  - id: output_tree
    type:
      - 'null'
      - boolean
    doc: Output the genealogy (tree) for each replication
    inputBinding:
      position: 103
      prefix: -T
  - id: rho
    type:
      - 'null'
      - float
    doc: Recombination rate (rho = 4Nr)
    inputBinding:
      position: 103
      prefix: -r
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the random number generator
    inputBinding:
      position: 103
      prefix: -s
  - id: theta
    type:
      - 'null'
      - float
    doc: Mutation rate (theta = 4Nu)
    inputBinding:
      position: 103
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastsimbac:1.0.1_bd3ad13d8f79--h503566f_7
stdout: fastsimbac.out
