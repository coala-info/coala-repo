cwlVersion: v1.2
class: CommandLineTool
baseCommand: weakarg
label: clonalorigin
doc: "Perform inference of recombination in bacteria using the ClonalOrigin model.\n\
  \nTool homepage: https://github.com/xavierdidelot/ClonalOrigin"
inputs:
  - id: treefile
    type: File
    doc: Input tree file
    inputBinding:
      position: 1
  - id: datafile
    type: File
    doc: Input data file
    inputBinding:
      position: 2
  - id: burnin_iterations
    type:
      - 'null'
      - int
    doc: Sets the number of burn-in iterations
    inputBinding:
      position: 103
      prefix: -x
  - id: delta
    type:
      - 'null'
      - float
    doc: Sets the value of delta
    inputBinding:
      position: 103
      prefix: -D
  - id: forbid_topology_changes
    type:
      - 'null'
      - boolean
    doc: Forbid topology changes, (allowing updates of coalescence times)
    inputBinding:
      position: 103
      prefix: -f
  - id: greedy_best_fit
    type:
      - 'null'
      - int
    doc: Greedily compute the 'best fit' tree, given the recombination observed 
      on the current tree
    inputBinding:
      position: 103
      prefix: -G
  - id: iterations_after_burnin
    type:
      - 'null'
      - int
    doc: Sets the number of iterations after burn-in
    inputBinding:
      position: 103
      prefix: -y
  - id: iterations_between_samples
    type:
      - 'null'
      - int
    doc: Sets the number of iterations between samples
    inputBinding:
      position: 103
      prefix: -z
  - id: move_weightings
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the ELEVEN (real valued) move weightings to the given vector, 
      separated by commas
    inputBinding:
      position: 103
      prefix: -a
  - id: pre_burnin_iterations
    type:
      - 'null'
      - int
    doc: Sets the number of pre burn-in iterations
    inputBinding:
      position: 103
      prefix: -w
  - id: random_tree_params
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the SIX parameters for creating random Recombination Trees under 
      the inference model (N, n_B, l_B, delta, theta, rho)
    inputBinding:
      position: 103
      prefix: -i
  - id: rho
    type:
      - 'null'
      - string
    doc: Sets the value of rho. Use sNUM instead of NUM for per-site
    inputBinding:
      position: 103
      prefix: -R
  - id: seed
    type:
      - 'null'
      - int
    doc: Use given seed to initiate random number generator
    inputBinding:
      position: 103
      prefix: -s
  - id: subset_regions
    type:
      - 'null'
      - string
    doc: Run on a subset of NUM regions determined by seed SEED
    inputBinding:
      position: 103
      prefix: -S
  - id: temperature
    type:
      - 'null'
      - float
    doc: Tempered at 'temperature' t for topological updates
    inputBinding:
      position: 103
      prefix: -t
  - id: tempered_steps
    type:
      - 'null'
      - int
    doc: Perform r tempered steps between topological updates
    inputBinding:
      position: 103
      prefix: -r
  - id: theta
    type:
      - 'null'
      - string
    doc: Sets the value of theta. Use sNUM instead of NUM for per-site
    inputBinding:
      position: 103
      prefix: -T
  - id: upgma_tree
    type:
      - 'null'
      - boolean
    doc: Start from UPGMA tree, rather than the default random tree
    inputBinding:
      position: 103
      prefix: -U
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: outputfile
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clonalorigin:v1.0-3-deb_cv1
