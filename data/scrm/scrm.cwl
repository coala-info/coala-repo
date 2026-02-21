cwlVersion: v1.2
class: CommandLineTool
baseCommand: scrm
label: scrm
doc: "Fast & accurate coalescent simulations\n\nTool homepage: https://scrm.github.io/"
inputs:
  - id: n_samp
    type: int
    doc: Total number of samples
    inputBinding:
      position: 1
  - id: n_loci
    type: int
    doc: Number of independent loci to simulate
    inputBinding:
      position: 2
  - id: approximation_window
    type:
      - 'null'
      - int
    doc: Set the approximation window length to l
    inputBinding:
      position: 103
      prefix: -l
  - id: change_global_growth_rate
    type:
      - 'null'
      - type: array
        items: float
    doc: Change the exponential growth rate of all populations to a at time t
    inputBinding:
      position: 103
      prefix: -eG
  - id: change_growth_rate
    type:
      - 'null'
      - type: array
        items: float
    doc: Change the exponential growth rate of population i to a at time t
    inputBinding:
      position: 103
      prefix: -eg
  - id: change_migration_ij
    type:
      - 'null'
      - type: array
        items: float
    doc: Set the migration rate from population j to population i to M at time t
    inputBinding:
      position: 103
      prefix: -em
  - id: change_migration_matrix
    type:
      - 'null'
      - type: array
        items: float
    doc: Changes the migration matrix at time t
    inputBinding:
      position: 103
      prefix: -ema
  - id: change_migration_rate
    type:
      - 'null'
      - type: array
        items: float
    doc: Change the symmetric migration rate to M/(npop-1) at time t
    inputBinding:
      position: 103
      prefix: -eM
  - id: change_population_size
    type:
      - 'null'
      - type: array
        items: float
    doc: Change the size of population i to n*N0 at time t
    inputBinding:
      position: 103
      prefix: -en
  - id: change_recombination
    type:
      - 'null'
      - type: array
        items: float
    doc: Change the recombination rate R at sequence position p
    inputBinding:
      position: 103
      prefix: -sr
  - id: digits
    type:
      - 'null'
      - int
    doc: Specify the number of significant digits used in the output
    default: 6
    inputBinding:
      position: 103
      prefix: -p
  - id: global_growth_rate
    type:
      - 'null'
      - float
    doc: Set the exponential growth rate of all populations to a
    inputBinding:
      position: 103
      prefix: -G
  - id: global_population_size
    type:
      - 'null'
      - type: array
        items: float
    doc: Set the present day size of all populations to n*N0 at time t
    inputBinding:
      position: 103
      prefix: -eN
  - id: growth_rate
    type:
      - 'null'
      - type: array
        items: float
    doc: Set the exponential growth rate of population i to a
    inputBinding:
      position: 103
      prefix: -g
  - id: init_file
    type:
      - 'null'
      - File
    doc: Read genealogies at the beginning of the sequence
    inputBinding:
      position: 103
      prefix: -init
  - id: island_model
    type:
      - 'null'
      - type: array
        items: float
    doc: Use an island model with npop populations, where s1 to sn individuals are
      sampled each population. Optionally assume a symmetric migration rate of M.
    inputBinding:
      position: 103
      prefix: -I
  - id: migration_ij
    type:
      - 'null'
      - type: array
        items: float
    doc: Set the migration rate from population j to population i to M
    inputBinding:
      position: 103
      prefix: -m
  - id: migration_matrix
    type:
      - 'null'
      - type: array
        items: float
    doc: Sets the (backwards) migration matrix
    inputBinding:
      position: 103
      prefix: -ma
  - id: migration_rate
    type:
      - 'null'
      - float
    doc: Assume a symmetric migration rate of M/(npop-1)
    inputBinding:
      position: 103
      prefix: -M
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: Set the mutation rate to theta = 4N0*mu
    inputBinding:
      position: 103
      prefix: -t
  - id: partial_population_admixture
    type:
      - 'null'
      - type: array
        items: float
    doc: Partial Population admixture. Replaces a fraction of 1-p of population i
      with individuals from population j
    inputBinding:
      position: 103
      prefix: -eps
  - id: population_admixture
    type:
      - 'null'
      - type: array
        items: float
    doc: Population admixture. Replaces a fraction of 1-p of population i with individuals
      from population npop + 1
    inputBinding:
      position: 103
      prefix: -es
  - id: population_size
    type:
      - 'null'
      - type: array
        items: float
    doc: Set the present day size of population i to n*N0
    inputBinding:
      position: 103
      prefix: -n
  - id: print_model
    type:
      - 'null'
      - boolean
    doc: Prints information about the demographic model
    inputBinding:
      position: 103
      prefix: --print-model
  - id: print_newick
    type:
      - 'null'
      - boolean
    doc: Print the simulated local genealogies in Newick format
    inputBinding:
      position: 103
      prefix: -T
  - id: print_oriented_forest
    type:
      - 'null'
      - boolean
    doc: Print the simulated local genealogies in Oriented Forest format
    inputBinding:
      position: 103
      prefix: -O
  - id: print_sfs
    type:
      - 'null'
      - boolean
    doc: Print the Site Frequency Spectrum for each locus
    inputBinding:
      position: 103
      prefix: -oSFS
  - id: print_tmrca
    type:
      - 'null'
      - boolean
    doc: Print the TMRCA and the local tree length for each segment
    inputBinding:
      position: 103
      prefix: -L
  - id: recombination
    type:
      - 'null'
      - type: array
        items: float
    doc: Set recombination rate to R and locus length to L
    inputBinding:
      position: 103
      prefix: -r
  - id: sample_at_time
    type:
      - 'null'
      - type: array
        items: float
    doc: Sample s1 to sn individuals from their corresponding populations at time
      t. Optionally assume a symmetric migration rate of M.
    inputBinding:
      position: 103
      prefix: -eI
  - id: scaling
    type:
      - 'null'
      - string
    doc: Scaling of sequence positions. Either relative (rel), absolute (abs) or as
      in ms (default).
    inputBinding:
      position: 103
      prefix: -SC
  - id: seed
    type:
      - 'null'
      - type: array
        items: int
    doc: The random seed to use. Takes up to three integer numbers.
    inputBinding:
      position: 103
      prefix: -seed
  - id: speciation_event
    type:
      - 'null'
      - type: array
        items: float
    doc: Speciation event at time t. Creates population j from individuals of population
      i
    inputBinding:
      position: 103
      prefix: -ej
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrm:1.7.4--h9948957_5
stdout: scrm.out
