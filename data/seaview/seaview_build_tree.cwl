cwlVersion: v1.2
class: CommandLineTool
baseCommand: seaview
label: seaview_build_tree
doc: "compute a phylogenetic tree from an input alignment file (no window creation)\n\nTool homepage: http://doua.prabi.fr/software/seaview"
inputs:
  - id: build_tree_mode
    type: ['null', boolean]
    default: true
    doc: "Select the non-interactive mode: compute a phylogenetic tree from an input alignment file (no window creation)"
    inputBinding:
      position: 1
      prefix: -build_tree
  - id: output_file
    type: ['null', string]
    doc: "use fname as name of the output tree"
    inputBinding:
      position: 2
      prefix: -o
  - id: distance
    type: ['null', string]
    doc: "computes the tree with a distance method using dist_name (observed, JC, K2P, logdet, Ka, Ks, Poisson or Kimura)"
    inputBinding:
      position: 2
      prefix: -distance
  - id: distance_matrix
    type: ['null', string]
    doc: "don't compute the tree, but write to fname the matrix of pairwise distances"
    inputBinding:
      position: 2
      prefix: -distance_matrix
  - id: nj
    type: ['null', boolean]
    doc: "compute the distance tree by the Neighbor-Joining method (default is BioNJ)"
    inputBinding:
      position: 2
      prefix: -NJ
  - id: parsimony
    type: ['null', boolean]
    doc: "compute the tree by the parsimony method"
    inputBinding:
      position: 2
      prefix: -parsimony
  - id: search
    type: ['null', string]
    doc: "controls how much rearrangement is done to find better trees (more, less or one; DNA parsimony only)"
    inputBinding:
      position: 2
      prefix: -search
  - id: nogaps
    type: ['null', boolean]
    doc: "remove all gap-containing sites before computations"
    inputBinding:
      position: 2
      prefix: -nogaps
  - id: replicates
    type: ['null', int]
    doc: "use n bootstrap replicates to compute tree branch support"
    inputBinding:
      position: 2
      prefix: -replicates
  - id: jumbles
    type: ['null', int]
    doc: "jumble sequence order n times (parsimony only)"
    inputBinding:
      position: 2
      prefix: -jumbles
  - id: gaps_as_unknown
    type: ['null', boolean]
    doc: "encode gaps as unknown character state (parsimony only)"
    inputBinding:
      position: 2
      prefix: -gaps_as_unknown
  - id: sites
    type: ['null', string]
    doc: "use the named selection of sites from the input alignment"
    inputBinding:
      position: 2
      prefix: -sites
  - id: species
    type: ['null', string]
    doc: "use the named group of species from the input alignment"
    inputBinding:
      position: 2
      prefix: -species
  - id: fontsize
    type: ['null', int]
    doc: "font size used for the tree plot or alignment windows"
    inputBinding:
      position: 2
      prefix: -fontsize
  - id: fast
    type: ['null', boolean]
    doc: "sequences will be displayed faster but less smoothly"
    inputBinding:
      position: 2
      prefix: -fast
  - id: input_file
    type: File
    doc: "alignment or sequence file to be read (always the last argument)"
    inputBinding:
      position: 99
outputs:
  - id: distance_matrix_file
    type: ['null', File]
    doc: Pairwise distance matrix written with -distance_matrix
    outputBinding:
      glob: $(inputs.distance_matrix)
  - id: output_result
    type: ['null', File]
    doc: Output written with -o
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seaview:v1-4.7-1-deb_cv1
stdout: seaview_build_tree.out
