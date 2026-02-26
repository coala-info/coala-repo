cwlVersion: v1.2
class: CommandLineTool
baseCommand: nodetraits
label: bayescode_nodetraits
doc: "Processes traits for nodes in a phylogenetic tree.\n\nTool homepage: https://github.com/ThibaultLatrille/bayescode"
inputs:
  - id: chain_name
    type: string
    doc: Chain name (output file prefix)
    inputBinding:
      position: 1
  - id: df
    type:
      - 'null'
      - int
    doc: Invert Wishart degree of freedom
    inputBinding:
      position: 102
      prefix: --df
  - id: every
    type:
      - 'null'
      - int
    doc: Number of MCMC iterations between two saved point in the trace.
    inputBinding:
      position: 102
      prefix: --every
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output files.
    inputBinding:
      position: 102
      prefix: --force
  - id: ignore_rest
    type:
      - 'null'
      - boolean
    doc: Ignores the rest of the labeled arguments following this flag.
    inputBinding:
      position: 102
      prefix: --ignore_rest
  - id: traitsfile
    type: string
    doc: Traits file for taxon at the leaves
    inputBinding:
      position: 102
      prefix: --traitsfile
  - id: tree
    type: string
    doc: File path to the tree (NHX format).
    inputBinding:
      position: 102
      prefix: --tree
  - id: uniq_kappa
    type:
      - 'null'
      - boolean
    doc: Unique kappa for the invert Wishart matrix prior (otherwise 1 for each 
      dimension)
    inputBinding:
      position: 102
      prefix: --uniq_kappa
  - id: until
    type:
      - 'null'
      - int
    doc: Maximum number of (saved) iterations (-1 means unlimited).
    inputBinding:
      position: 102
      prefix: --until
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayescode:1.3.4--h9948957_0
stdout: bayescode_nodetraits.out
