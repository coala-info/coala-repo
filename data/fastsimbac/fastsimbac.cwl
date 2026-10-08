cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastSimBac
label: fastsimbac
doc: "A fast simulator for sequences under the coalescent with recombination (bacterial\n  genomes with gene conversion), with population structure, variable population size and\n  migration. The simulated sites and trees go to standard output.\n\nTool homepage: https://bitbucket.org/nicofmay/fastsimbac/"
requirements:
  - class: InlineJavascriptRequirement
    expressionLib:
      - |
        function flatEvents(flag, lists) {
          var r = [];
          if (lists) {
            for (var i = 0; i < lists.length; i++) {
              r.push(flag);
              for (var j = 0; j < lists[i].length; j++) { r.push(lists[i][j]); }
            }
          }
          return r;
        }
arguments:
  - position: 29
    valueFrom: "$(flatEvents('-eG', inputs.event_growth_all))"
  - position: 30
    valueFrom: "$(flatEvents('-eg', inputs.event_growth_pop))"
  - position: 31
    valueFrom: "$(flatEvents('-eM', inputs.event_migration_all))"
  - position: 32
    valueFrom: "$(flatEvents('-em', inputs.event_migration_ij))"
  - position: 33
    valueFrom: "$(flatEvents('-ema', inputs.event_migration_matrix))"
  - position: 34
    valueFrom: "$(flatEvents('-eN', inputs.event_size_all))"
  - position: 35
    valueFrom: "$(flatEvents('-en', inputs.event_size_pop))"
  - position: 36
    valueFrom: "$(flatEvents('-es', inputs.event_split))"
  - position: 37
    valueFrom: "$(flatEvents('-ej', inputs.event_join))"
inputs:
  - id: sample_size
    type: int
    doc: "Number of chromosomes (samples) to simulate"
    inputBinding:
      position: 1
  - id: region_length
    type: int
    doc: "Sequence (region) length in base pairs"
    inputBinding:
      position: 2
  - id: seed
    type: ['null', int]
    doc: "Random seed"
    inputBinding:
      position: 11
      prefix: -s
  - id: debug
    type: ['null', boolean]
    doc: "Enable debugging messages"
    inputBinding:
      position: 12
      prefix: -d
  - id: iterations
    type: ['null', int]
    doc: "Number of iterations"
    inputBinding:
      position: 13
      prefix: -i
  - id: theta
    type: ['null', double]
    doc: "Mutation rate per site per 2N generations"
    inputBinding:
      position: 14
      prefix: -t
  - id: clonal_frame
    type: ['null', File]
    doc: "Input clonal frame to fix simulations on (sample names must be integers from 0 on)"
    inputBinding:
      position: 15
      prefix: -C
  - id: burn_in
    type: ['null', int]
    doc: "Burn in: sequence length in base pairs used to initialize the recombination process"
    inputBinding:
      position: 16
      prefix: -b
  - id: recombination
    type: ['null', 'double[]']
    doc: "Two values: r (recombination or gene conversion initiation rate per individual, per base pair, per 2N generations) then lambda (mean tract length in base pairs)"
    inputBinding:
      position: 17
      prefix: -r
  - id: between_species_recombination
    type: ['null', 'double[]']
    doc: "Two values: r2 (between-species recombination initiation rate) then lambda2 (mean tract length in base pairs)"
    inputBinding:
      position: 18
      prefix: -x
  - id: print_trees
    type: ['null', boolean]
    doc: "Print each local tree in Newick format to standard out"
    inputBinding:
      position: 19
      prefix: -T
  - id: recombination_map
    type: ['null', File]
    doc: "Tab delimited file: first two columns give the position range scaled to the unit interval, last column the ratio to the base line recombination rate"
    inputBinding:
      position: 20
      prefix: -R
  - id: freq_dist_file
    type: ['null', File]
    doc: "Tab delimited frequency distribution file of SNP allele frequencies (bin upper bound, desired bin frequency)"
    inputBinding:
      position: 21
      prefix: -F
  - id: freq_flip
    type: ['null', int]
    default: 0
    doc: "Used with freq_dist_file: 1 if SNPs with derived allele frequency above 1.0 should have alleles flipped, 0 otherwise"
    inputBinding:
      position: 22
      valueFrom: "$(inputs.freq_dist_file ? self : null)"
  - id: growth_rate
    type: ['null', double]
    doc: "Growth rate alpha across populations, where alpha=-log(Np/Nr)"
    inputBinding:
      position: 23
      prefix: -G
  - id: island_model
    type: ['null', 'string[]']
    doc: "n n1 n2 ... mig_rate: assign all elements of the migration matrix for n populations; values are set to mig_rate/(n-1)"
    inputBinding:
      position: 24
      prefix: -I
  - id: migration_ij
    type: ['null', 'string[]']
    doc: "i j m: assign the i,j-th element of the migration matrix to m"
    inputBinding:
      position: 25
      prefix: -m
  - id: migration_matrix
    type: ['null', 'string[]']
    doc: "m_11 m_12 ... m_nn: assign all values of the migration matrix"
    inputBinding:
      position: 26
      prefix: -ma
  - id: pop_size
    type: ['null', 'string[]']
    doc: "i size: population i has size set to size*N_0"
    inputBinding:
      position: 27
      prefix: -n
  - id: pop_growth
    type: ['null', 'string[]']
    doc: "i alpha: growth rate of population i (must appear after the island model option)"
    inputBinding:
      position: 28
      prefix: -g
  - id: event_growth_all
    type:
      - 'null'
      - type: array
        items:
          type: array
          items: string
    doc: "t alpha: assign growth rate alpha for all populations at time t. Give one list per occurrence of the option -eG."
  - id: event_growth_pop
    type:
      - 'null'
      - type: array
        items:
          type: array
          items: string
    doc: "t i alpha: assign growth rate alpha of population i at time t. Give one list per occurrence of the option -eg."
  - id: event_migration_all
    type:
      - 'null'
      - type: array
        items:
          type: array
          items: string
    doc: "t m: assign migration rate m for all elements of the migration matrix at time t. Give one list per occurrence of the option -eM."
  - id: event_migration_ij
    type:
      - 'null'
      - type: array
        items:
          type: array
          items: string
    doc: "t i j m_ij: assign the migration rate of the i,j-th element at time t. Give one list per occurrence of the option -em."
  - id: event_migration_matrix
    type:
      - 'null'
      - type: array
        items:
          type: array
          items: string
    doc: "t n m_11 m_12 ... m_nn: assign migration rates within the matrix for n populations at time t. Give one list per occurrence of the option -ema."
  - id: event_size_all
    type:
      - 'null'
      - type: array
        items:
          type: array
          items: string
    doc: "t size: new population sizes at time t for all populations (size*N_0). Give one list per occurrence of the option -eN."
  - id: event_size_pop
    type:
      - 'null'
      - type: array
        items:
          type: array
          items: string
    doc: "t i size_i: new size of population i at time t (size_i*N_0). Give one list per occurrence of the option -en."
  - id: event_split
    type:
      - 'null'
      - type: array
        items:
          type: array
          items: string
    doc: "t i p: at time t a proportion p of chromosomes from population i migrate to population i+1. Give one list per occurrence of the option -es."
  - id: event_join
    type:
      - 'null'
      - type: array
        items:
          type: array
          items: string
    doc: "t i j: at time t all chromosomes of population i migrate to population j. Give one list per occurrence of the option -ej."
outputs:
  - id: simulation
    type: stdout
    doc: Simulation output (sites, trees)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastsimbac:1.0.1_bd3ad13d8f79--h503566f_7
stdout: fastsimbac.out
