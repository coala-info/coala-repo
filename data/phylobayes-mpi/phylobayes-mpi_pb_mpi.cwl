cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mpirun
label: phylobayes-mpi_pb_mpi
doc: "Bayesian MCMC sampling of phylogenetic trees and substitution models (pb_mpi, run under mpirun). Creates a new chain from a data file, or restarts an existing chain.\n\nTool homepage: https://github.com/bayesiancook/pbmpi"
inputs:
  - id: np
    type: int
    doc: "number of parallel processes (mpirun -np; at least 2)"
    default: 2
    inputBinding:
      position: 1
      prefix: "-np"
  - id: datafile
    type:
      - 'null'
      - File
    doc: "data file (alignment) to create a new chain; omit it to restart an existing chain (give its files in chain_files). It is staged in the working directory, because the chain files record its path"
    inputBinding:
      position: 3
      prefix: "-d"
      valueFrom: "$(self.basename)"
  - id: infinite_mixture
    type:
      - 'null'
      - boolean
    doc: "infinite mixture (Dirichlet process) of equilibrium frequency profiles (-cat; use with -dp)"
    inputBinding:
      position: 4
      prefix: "-cat"
  - id: dp
    type:
      - 'null'
      - boolean
    doc: "Dirichlet process (-dp)"
    inputBinding:
      position: 4
      prefix: "-dp"
  - id: ncat
    type:
      - 'null'
      - int
    doc: "finite mixture of equilibrium frequency profiles with this many categories (1 = one matrix model)"
    inputBinding:
      position: 4
      prefix: "-ncat"
  - id: catfix
    type:
      - 'null'
      - string
    doc: "specify a fixed pre-defined mixture of profiles"
    inputBinding:
      position: 4
      prefix: "-catfix"
  - id: lg
    type:
      - 'null'
      - boolean
    doc: "Le and Gascuel 2008 matrix"
    inputBinding:
      position: 4
      prefix: "-lg"
  - id: wag
    type:
      - 'null'
      - boolean
    doc: "Whelan and Goldman 2001 matrix"
    inputBinding:
      position: 4
      prefix: "-wag"
  - id: jtt
    type:
      - 'null'
      - boolean
    doc: "Jones, Taylor, Thornton 1992 matrix"
    inputBinding:
      position: 4
      prefix: "-jtt"
  - id: gtr
    type:
      - 'null'
      - boolean
    doc: "general time reversible"
    inputBinding:
      position: 4
      prefix: "-gtr"
  - id: poisson
    type:
      - 'null'
      - boolean
    doc: "Poisson matrix, all relative exchangeabilities equal to 1 (Felsenstein 1981)"
    inputBinding:
      position: 4
      prefix: "-poisson"
  - id: dgam_ncat
    type:
      - 'null'
      - int
    doc: "discrete gamma with this many categories (4 by default, 1 = uniform rates model)"
    inputBinding:
      position: 4
      prefix: "-dgam"
  - id: exclude_constant_columns
    type:
      - 'null'
      - boolean
    doc: "exclude constant columns"
    inputBinding:
      position: 4
      prefix: "-dc"
  - id: start_tree
    type:
      - 'null'
      - File
    doc: "start the chain from this tree"
    inputBinding:
      position: 4
      prefix: "-t"
  - id: fixed_tree
    type:
      - 'null'
      - File
    doc: "run the chain under this fixed tree"
    inputBinding:
      position: 4
      prefix: "-T"
  - id: save_every_until
    type:
      - 'null'
      - type: array
        items: int
    doc: "saving frequency and chain length: two integers, every and until (until = -1: forever)"
    inputBinding:
      position: 4
      prefix: "-x"
  - id: force_checks
    type:
      - 'null'
      - boolean
    doc: "force checks"
    inputBinding:
      position: 4
      prefix: "-f"
  - id: save_all
    type:
      - 'null'
      - boolean
    doc: "save all (-s)"
    inputBinding:
      position: 4
      prefix: "-s"
  - id: save_only_trees
    type:
      - 'null'
      - boolean
    doc: "save only the trees (-S)"
    inputBinding:
      position: 4
      prefix: "-S"
  - id: chainname
    type: string
    doc: "name of the chain (prefix of the chain files)"
    inputBinding:
      position: 5
  - id: chain_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "files of an existing chain (chainname.*) to restart it"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: chain_output
    type:
      - 'null'
      - type: array
        items: File
    doc: "Chain files (.chain, .trace, .treelist, .param, .monitor, .run)"
    outputBinding:
      glob: "$(inputs.chainname).*"
arguments:
  - position: 2
    valueFrom: pb_mpi
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.datafile)
      - $(inputs.chain_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
stdout: phylobayes-mpi_pb_mpi.out
