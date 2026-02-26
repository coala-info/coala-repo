cwlVersion: v1.2
class: CommandLineTool
baseCommand: mspms
label: msprime_mspms
doc: "mspms is an ms-compatible interface to the msprime library. It simulates the
  coalescent with recombination for a variety of demographic models and outputs the
  results in a text-based format. It supports a subset of the functionality available
  in ms and aims for full compatibility.\n\nTool homepage: https://github.com/tskit-dev/msprime"
inputs:
  - id: sample_size
    type: int
    doc: The number of individuals in the sample
    inputBinding:
      position: 1
  - id: num_replicates
    type: int
    doc: Number of independent replicates
    inputBinding:
      position: 2
  - id: admixture
    type:
      - 'null'
      - type: array
        items: string
    doc: Split the specified population into a new population, such that the 
      specified proportion of lineages remains in the population population_id. 
      Forwards in time this corresponds to an admixture event. The new 
      population has ID num_populations + 1. Migration rates to and from the new
      population are set to 0, and growth rate is 0 and the population size for 
      the new population is N0.
    inputBinding:
      position: 103
      prefix: --admixture
  - id: growth_rate
    type:
      - 'null'
      - float
    doc: Set the growth rate to alpha for all populations.
    inputBinding:
      position: 103
      prefix: --growth-rate
  - id: growth_rate_change
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the growth rate for all populations to alpha at time t
    inputBinding:
      position: 103
      prefix: --growth-rate-change
  - id: migration_matrix
    type:
      - 'null'
      - type: array
        items: string
    doc: Sets the migration matrix to the specified value. The entries are in 
      the order M[1,1], M[1, 2], ..., M[2, 1],M[2, 2], ..., M[N, N], where N is 
      the number of populations.
    inputBinding:
      position: 103
      prefix: --migration-matrix
  - id: migration_matrix_change
    type:
      - 'null'
      - type: array
        items: string
    doc: Sets the migration matrix to the specified value at time t.The entries 
      are in the order M[1,1], M[1, 2], ..., M[2, 1],M[2, 2], ..., M[N, N], 
      where N is the number of populations.
    inputBinding:
      position: 103
      prefix: --migration-matrix-change
  - id: migration_matrix_entry
    type:
      - 'null'
      - type: array
        items: string
    doc: Sets an entry M[dest, source] in the migration matrix to the specified 
      rate. source and dest are (1-indexed) population IDs. Multiple options can
      be specified.
    inputBinding:
      position: 103
      prefix: --migration-matrix-entry
  - id: migration_matrix_entry_change
    type:
      - 'null'
      - type: array
        items: string
    doc: Sets an entry M[dest, source] in the migration matrix to the specified 
      rate at the specified time. source and dest are (1-indexed) population 
      IDs.
    inputBinding:
      position: 103
      prefix: --migration-matrix-entry-change
  - id: migration_rate_change
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the symmetric island model migration rate to x / (npop - 1) at time
      t
    inputBinding:
      position: 103
      prefix: --migration-rate-change
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: Mutation rate theta=4*N0*mu
    inputBinding:
      position: 103
      prefix: --mutation-rate
  - id: population_growth_rate
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the growth rate to alpha for a specific population.
    inputBinding:
      position: 103
      prefix: --population-growth-rate
  - id: population_growth_rate_change
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the growth rate for a specific population to alpha at time t
    inputBinding:
      position: 103
      prefix: --population-growth-rate-change
  - id: population_size
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the size of a specific population to size*N0.
    inputBinding:
      position: 103
      prefix: --population-size
  - id: population_size_change
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the population size for a specific population to x * N0 at time t
    inputBinding:
      position: 103
      prefix: --population-size-change
  - id: population_split
    type:
      - 'null'
      - type: array
        items: string
    doc: Move all lineages in population dest to source at time t. Forwards in 
      time, this corresponds to a population split in which lineages in source 
      split into dest. All migration rates for population source are set to 
      zero.
    inputBinding:
      position: 103
      prefix: --population-split
  - id: precision
    type:
      - 'null'
      - int
    doc: Number of values after decimal place to print
    inputBinding:
      position: 103
      prefix: --precision
  - id: print_trees
    type:
      - 'null'
      - boolean
    doc: Print out trees in Newick format
    inputBinding:
      position: 103
      prefix: --trees
  - id: random_seeds
    type:
      - 'null'
      - type: array
        items: string
    doc: Random seeds (must be three integers)
    inputBinding:
      position: 103
      prefix: --random-seeds
  - id: recombination
    type:
      - 'null'
      - type: array
        items: string
    doc: Recombination at rate rho=4*N0*r where r is the rate of recombination 
      between the ends of the region being simulated; num_loci is the number of 
      sites between which recombination can occur
    inputBinding:
      position: 103
      prefix: --recombination
  - id: size_change
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the population size for all populations to x * N0 at time t
    inputBinding:
      position: 103
      prefix: --size-change
  - id: structure
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample from populations with the specified deme structure. The 
      arguments are of the form 'num_populations n1 n2 ... [4N0m]', specifying 
      the number of populations, the sample configuration, and optionally, the 
      migration rate for a symmetric island model
    inputBinding:
      position: 103
      prefix: --structure
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msprime:0.4.0--py35_gsl1.16_0
stdout: msprime_mspms.out
