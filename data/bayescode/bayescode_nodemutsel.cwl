cwlVersion: v1.2
class: CommandLineTool
baseCommand: nodemutsel
label: bayescode_nodemutsel
doc: "DatedMutSel\n\nTool homepage: https://github.com/ThibaultLatrille/bayescode"
inputs:
  - id: chain_name
    type: string
    doc: Chain name (output file prefix)
    inputBinding:
      position: 1
  - id: alignment
    type: File
    doc: File path to alignment (PHYLIP format).
    inputBinding:
      position: 102
      prefix: --alignment
  - id: arithmetic
    type:
      - 'null'
      - boolean
    doc: Use arithmetic mean instead of geometric (experimental).
    inputBinding:
      position: 102
      prefix: --arithmetic
  - id: clamp_corr_matrix
    type:
      - 'null'
      - boolean
    doc: Clamp the correlation matrix (experimental).
    inputBinding:
      position: 102
      prefix: --clamp_corr_matrix
  - id: clamp_nuc_matrix
    type:
      - 'null'
      - boolean
    doc: Clamp the nucleotide matrix (experimental).
    inputBinding:
      position: 102
      prefix: --clamp_nuc_matrix
  - id: clamp_pop_sizes
    type:
      - 'null'
      - boolean
    doc: Clamp the branch population size (experimental).
    inputBinding:
      position: 102
      prefix: --clamp_pop_sizes
  - id: df
    type:
      - 'null'
      - int
    doc: Invert Wishart degree of freedom (experimental).
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
  - id: fossils
    type:
      - 'null'
      - File
    doc: File path to the fossils calibration in tsv format with columns 
      `NodeName`, `Age, `LowerBound` and `UpperBound`.
    inputBinding:
      position: 102
      prefix: --fossils
  - id: ignore_rest
    type:
      - 'null'
      - boolean
    doc: Ignores the rest of the labeled arguments following this flag.
    inputBinding:
      position: 102
      prefix: --
  - id: move_root_pop_size
    type:
      - 'null'
      - boolean
    doc: Move Ne at the root, for the equilibrium frequencies (experimental)
    inputBinding:
      position: 102
      prefix: --move_root_pop_size
  - id: ncat
    type:
      - 'null'
      - int
    doc: Number of components for the amino-acid fitness profiles (truncation of
      the stick-breaking process).
    inputBinding:
      position: 102
      prefix: --ncat
  - id: polymorphism_aware
    type:
      - 'null'
      - boolean
    doc: Use polymorphic data (experimental).
    inputBinding:
      position: 102
      prefix: --polymorphism_aware
  - id: precision
    type:
      - 'null'
      - int
    doc: The precision of Poisson-Random-Field computations (experimental).
    inputBinding:
      position: 102
      prefix: --precision
  - id: profiles
    type:
      - 'null'
      - File
    doc: File path the fitness profiles (tsv or csv), thus considered fixed. 
      Each line must contains the fitness of each of the 20 amino-acid, thus 
      summing to one. If same number of profiles as the codon alignment, site 
      allocations are considered fixed. If smaller than the alignment size, site
      allocations are computed and `ncat` is given by the number of profiles in 
      the file.
    inputBinding:
      position: 102
      prefix: --profiles
  - id: traitsfile
    type:
      - 'null'
      - File
    doc: File path to the life-history trait (in log-space) in tsv format. The 
      First column is `TaxonName` (taxon matching the name in the alignment) and
      the next columns are traits.
    inputBinding:
      position: 102
      prefix: --traitsfile
  - id: tree
    type: File
    doc: File path to the tree (NHX format).
    inputBinding:
      position: 102
      prefix: --tree
  - id: uniq_kappa
    type:
      - 'null'
      - boolean
    doc: Unique kappa for the invert Wishart matrix prior, otherwise 1 for each 
      dimension (experimental).
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
stdout: bayescode_nodemutsel.out
