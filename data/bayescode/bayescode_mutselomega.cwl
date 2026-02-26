cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutselomega
label: bayescode_mutselomega
doc: "A tool for analyzing codon models with multiple Omegas.\n\nTool homepage: https://github.com/ThibaultLatrille/bayescode"
inputs:
  - id: chain_name
    type: string
    doc: Chain name (output file prefix)
    inputBinding:
      position: 1
  - id: alignment
    type: string
    doc: File path to alignment (PHYLIP format).
    inputBinding:
      position: 102
      prefix: --alignment
  - id: every
    type:
      - 'null'
      - int
    doc: Number of MCMC iterations between two saved point in the trace.
    inputBinding:
      position: 102
      prefix: --every
  - id: flatfitness
    type:
      - 'null'
      - boolean
    doc: Fitness profiles are flattened (and `ncat` equals to 1). This option is
      not compatible with the option `profiles`.
    inputBinding:
      position: 102
      prefix: --flatfitness
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output files.
    inputBinding:
      position: 102
      prefix: --force
  - id: freeomega
    type:
      - 'null'
      - boolean
    doc: ω is allowed to vary (default ω is 1.0). Combined with the option 
      `flatfitness`, we obtain the classical, ω-based codon model (Muse & Gaut).
      Without the option `flatfitness`, we obtain the mutation-selection codon 
      model with a multiplicative factor (ω⁎).
    inputBinding:
      position: 102
      prefix: --freeomega
  - id: ignore_rest
    type:
      - 'null'
      - boolean
    doc: Ignores the rest of the labeled arguments following this flag.
    inputBinding:
      position: 102
      prefix: --ignore_rest
  - id: ncat
    type:
      - 'null'
      - int
    doc: Number of components for the amino-acid fitness profiles (truncation of
      the stick-breaking process).
    inputBinding:
      position: 102
      prefix: --ncat
  - id: omegaarray
    type:
      - 'null'
      - string
    doc: File path to ω values (one ω per line), thus considered fixed. 
      `freeomega` is overridden to false and `omegancat` equals to the number of
      ω in the file.
    inputBinding:
      position: 102
      prefix: --omegaarray
  - id: omegancat
    type:
      - 'null'
      - int
    doc: Number of components for ω (finite mixture).
    inputBinding:
      position: 102
      prefix: --omegancat
  - id: omegashift
    type:
      - 'null'
      - float
    doc: Additive shift applied to all ω (0.0 for the general case).
    default: 0.0
    inputBinding:
      position: 102
      prefix: --omegashift
  - id: profiles
    type:
      - 'null'
      - string
    doc: File path the fitness profiles (tsv or csv), thus considered fixed. 
      Each line must contains the fitness of each of the 20 amino-acid, thus 
      summing to one. If same number of profiles as the codon alignment, site 
      allocations are considered fixed. If smaller than the alignment size, site
      allocations are computed and `ncat` is given by the number of profiles in 
      the file.
    inputBinding:
      position: 102
      prefix: --profiles
  - id: tree
    type: string
    doc: File path to the tree (NHX format).
    inputBinding:
      position: 102
      prefix: --tree
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
stdout: bayescode_mutselomega.out
