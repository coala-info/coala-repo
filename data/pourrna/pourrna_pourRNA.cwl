cwlVersion: v1.2
class: CommandLineTool
baseCommand: pourrna
label: pourrna_pourRNA
doc: "Explore RNA energy landscapes\n\nTool homepage: https://github.com/ViennaRNA/pourRNA/"
inputs:
  - id: boltzmann_temp
    type:
      - 'null'
      - float
    doc: Set the temperature for the Boltzmann weight (in °C).
    default: 37.0
    inputBinding:
      position: 101
      prefix: --boltzmann-temp
  - id: dangling_end
    type:
      - 'null'
      - int
    doc: How to treat "dangling end" energies for bases adjacent to helices in 
      free ends and multi-loops.
    default: 2
    inputBinding:
      position: 101
      prefix: --dangling-end
  - id: delta_e
    type:
      - 'null'
      - float
    doc: Set the maximum energy difference that states in a basin can have 
      w.r.t. the local minimum (in kcal/mol).
    default: 65536.0
    inputBinding:
      position: 101
      prefix: --delta-e
  - id: dynamic_best_k
    type:
      - 'null'
      - boolean
    doc: Increases K if the MFE structure is not explored.
    default: false
    inputBinding:
      position: 101
      prefix: --dynamic-best-k
  - id: dynamic_max_to_hash
    type:
      - 'null'
      - boolean
    doc: Sets the dynamicMaxToHash variable for estimating the maximal number of
      states to be hashed in a gradient walk, by considering the maximal 
      available physical memory and the number of threads. This reduces the 
      probability of swapping.
    default: false
    inputBinding:
      position: 101
      prefix: --dynamic-max-to-hash
  - id: energy_model
    type:
      - 'null'
      - int
    doc: Set the energy model. 0=Turner model 2004, 1=Turner model 1999, 
      2=Andronescu model, 2007
    default: 0
    inputBinding:
      position: 101
      prefix: --energy-model
  - id: filter_best_k
    type:
      - 'null'
      - int
    doc: reduces outgoing transitions to the best K for each gradient basin
    inputBinding:
      position: 101
      prefix: --filter-best-k
  - id: final_structure
    type:
      - 'null'
      - string
    doc: the final structure of the exploration defining the last gradient basin
    inputBinding:
      position: 101
      prefix: --final-structure
  - id: gas_constant
    type:
      - 'null'
      - float
    doc: 'Set the gas constant in [kcal/(K*mol)]. You need this in order to compare
      the rate matrix with the results of other tools. ViennaRNA package: 0.00198717
      kcal/(K*mol) Barriers: 0.00198717 kcal/(K*mol) ELL Library: 0.0019871588 kcal/(K*mol)'
    default: 0.00198717
    inputBinding:
      position: 101
      prefix: --gas-constant
  - id: max_bp_dist_add
    type:
      - 'null'
      - int
    doc: 'Increases the maximum base pair distance for direct neighbor minima to be
      explored. Needs a start structure and a final structure in order to work. For
      all discovered minima m holds: bp_dist(m, start-structure) + bp_dist(m, final-structure)
      < d(start-structure, final-structure) + maxBPdist_add. If this parameter is
      given, the explorative flooding will not stop at the final structure! Instead
      it will explore all minima on the direct path and at its borders. This helps
      to evaluate optimal refolding paths in a post-processing step.'
    default: 65536
    inputBinding:
      position: 101
      prefix: --max-bp-dist-add
  - id: max_energy
    type:
      - 'null'
      - float
    doc: Sets the maximum energy that a state is allowed to have to be 
      considered by the flooder (in kcal/mol).
    default: 5.0
    inputBinding:
      position: 101
      prefix: --max-energy
  - id: max_neigh_e
    type:
      - 'null'
      - float
    doc: reduces outgoing transitions to the neighbored minima, for which the 
      energy is lower than the energy of the current minimum plus the filter 
      value. (E(neighbored minimum) < E(current minimum) + filterValue) for each
      gradient basin.
    inputBinding:
      position: 101
      prefix: --max-neigh-e
  - id: max_threads
    type:
      - 'null'
      - int
    doc: Sets the maximum number of threads for parallelized computation.
    inputBinding:
      position: 101
      prefix: --max-threads
  - id: max_to_hash
    type:
      - 'null'
      - int
    doc: Sets the maximum number of states to be hashed for a gradient walk.
    inputBinding:
      position: 101
      prefix: --max-to-hash
  - id: max_to_queue
    type:
      - 'null'
      - int
    doc: Sets the maximum number of states to be stored in the priority queue of
      the flooder.
    inputBinding:
      position: 101
      prefix: --max-to-queue
  - id: move_set
    type:
      - 'null'
      - int
    doc: 'Move set: 0 = insertion and deletion, 1 = shift moves, 2 = no lonely pair
      moves.'
    default: 0
    inputBinding:
      position: 101
      prefix: --move-set
  - id: sequence
    type:
      - 'null'
      - string
    doc: The RNA sequence of the molecule
    default: ACUGUAUGCGCGU
    inputBinding:
      position: 101
      prefix: --sequence
  - id: skip_diagonal
    type:
      - 'null'
      - boolean
    doc: Skip the computation of the diagonal of the rate matrix (it can be 
      skipped because some post-processing tools like treekin compute it per 
      default).
    default: false
    inputBinding:
      position: 101
      prefix: --skip-diagonal
  - id: start_structure
    type:
      - 'null'
      - string
    doc: the start structure of the exploration defining the first gradient 
      basin; defaults to the open chain
    inputBinding:
      position: 101
      prefix: --start-structure
  - id: start_structure_file
    type:
      - 'null'
      - File
    doc: File with start structures (one per line)
    inputBinding:
      position: 101
      prefix: --start-structure-file
  - id: temperature
    type:
      - 'null'
      - float
    doc: Set the temperature for the free energy calculation (in °C). (If "T" is
      set and "B" not, "B" is equals "T").
    default: 37.0
    inputBinding:
      position: 101
      prefix: --temperature
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose.
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: transition_prob
    type:
      - 'null'
      - File
    doc: If provided, the transition probability matrix will be written to the 
      given file name or 'STDOUT' when to write to standard output
    outputBinding:
      glob: $(inputs.transition_prob)
  - id: energy_file
    type:
      - 'null'
      - File
    doc: File to store all energies.
    outputBinding:
      glob: $(inputs.energy_file)
  - id: binary_rates_file
    type:
      - 'null'
      - File
    doc: File to store all rates in a treekin readable format.
    outputBinding:
      glob: $(inputs.binary_rates_file)
  - id: binary_rates_file_sparse
    type:
      - 'null'
      - File
    doc: 'File to store all rates in a sparse binary format: First value is the number
      of states (uint_32), then <uint_32 from>, <uint_32 number of how many value
      pairs to>, <value pair <uint_32 to, double rate from, to>> etc.'
    outputBinding:
      glob: $(inputs.binary_rates_file_sparse)
  - id: saddle_file
    type:
      - 'null'
      - File
    doc: Store all saddles in a CSV file.
    outputBinding:
      glob: $(inputs.saddle_file)
  - id: barriers_like_output
    type:
      - 'null'
      - File
    doc: Output the rates file and the structures in a format similar to the 
      tool barriers. For the same prefix is used for both files.
    outputBinding:
      glob: $(inputs.barriers_like_output)
  - id: partition_functions
    type:
      - 'null'
      - File
    doc: If provided, the partition function matrix will be written to the given
      file name.
    outputBinding:
      glob: $(inputs.partition_functions)
  - id: dot_plot
    type:
      - 'null'
      - File
    doc: If provided, the dotPlot will be written to the given file name. The 
      dotPlot contains the base pair probabilities for all structures in the 
      (filtered) energy landscape.
    outputBinding:
      glob: $(inputs.dot_plot)
  - id: dot_plot_per_basin
    type:
      - 'null'
      - File
    doc: Creates a dotplot for each gradient basin in the enrgy landscape. It 
      shows the Maximum Expected Accuracy (MEA) structure in the upper right 
      triangle and the basin representative in the lower left triangle.
    outputBinding:
      glob: $(inputs.dot_plot_per_basin)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pourrna:1.2.0--h6bb024c_0
