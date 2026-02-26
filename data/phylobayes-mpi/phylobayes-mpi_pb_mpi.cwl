cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpirun -np <np> pb_mpi
label: phylobayes-mpi_pb_mpi
doc: "creates a new chain, sampling from the posterior distribution, conditional on
  specified data\n\nTool homepage: https://github.com/bayesiancook/pbmpi"
inputs:
  - id: datafile
    type: File
    doc: data file
    inputBinding:
      position: 1
  - id: chainname
    type: string
    doc: name of the chain
    inputBinding:
      position: 2
  - id: catfix
    type:
      - 'null'
      - string
    doc: specifying a fixed pre-defined mixture of profiles
    inputBinding:
      position: 103
      prefix: -catfix
  - id: chain_length
    type:
      - 'null'
      - type: array
        items: int
    doc: 'chain length (until = -1 : forever)'
    default: -1
    inputBinding:
      position: 103
      prefix: -x
  - id: dgam_ncat
    type:
      - 'null'
      - int
    doc: discrete gamma. ncat = number of categories (4 by default, 1 = uniform 
      rates model)
    default: 4
    inputBinding:
      position: 103
      prefix: -dgam
  - id: dp
    type:
      - 'null'
      - boolean
    doc: infinite mixture (Dirichlet process) of equilibirium frequency profiles
    inputBinding:
      position: 103
      prefix: -dp
  - id: exclude_constant_columns
    type:
      - 'null'
      - boolean
    doc: excludes constant columns
    inputBinding:
      position: 103
      prefix: -dc
  - id: fixed_tree
    type:
      - 'null'
      - File
    doc: chain run under fixed, specified tree
    inputBinding:
      position: 103
      prefix: -T
  - id: force_checks
    type:
      - 'null'
      - boolean
    doc: forcing checks
    inputBinding:
      position: 103
      prefix: -f
  - id: gtr
    type:
      - 'null'
      - boolean
    doc: general time reversible
    inputBinding:
      position: 103
      prefix: -gtr
  - id: infinite_mixture
    type:
      - 'null'
      - boolean
    doc: infinite mixture (Dirichlet process) of equilibirium frequency profiles
    inputBinding:
      position: 103
      prefix: -cat
  - id: jtt
    type:
      - 'null'
      - boolean
    doc: Jones, Taylor, Thornton 1992
    inputBinding:
      position: 103
      prefix: -jtt
  - id: lg
    type:
      - 'null'
      - boolean
    doc: Le and Gascuel 2008
    inputBinding:
      position: 103
      prefix: -lg
  - id: ncat
    type:
      - 'null'
      - int
    doc: finite mixture of equilibirium frequency profiles
    inputBinding:
      position: 103
      prefix: -ncat
  - id: np
    type: int
    doc: number of parallel processes (should be at least 2)
    inputBinding:
      position: 103
      prefix: -np
  - id: poisson
    type:
      - 'null'
      - boolean
    doc: Poisson matrix, all relative exchangeabilities equal to 1 (Felsenstein 
      1981)
    inputBinding:
      position: 103
      prefix: -poisson
  - id: save_all
    type:
      - 'null'
      - boolean
    doc: save all
    inputBinding:
      position: 103
      prefix: -s
  - id: save_frequency
    type:
      - 'null'
      - type: array
        items: int
    doc: saving frequency
    inputBinding:
      position: 103
      prefix: -x
  - id: save_only_trees
    type:
      - 'null'
      - boolean
    doc: save only the trees
    inputBinding:
      position: 103
      prefix: -S
  - id: start_tree
    type:
      - 'null'
      - File
    doc: starts from specified tree
    inputBinding:
      position: 103
      prefix: -t
  - id: wag
    type:
      - 'null'
      - boolean
    doc: Whelan and Goldman 2001
    inputBinding:
      position: 103
      prefix: -wag
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
stdout: phylobayes-mpi_pb_mpi.out
