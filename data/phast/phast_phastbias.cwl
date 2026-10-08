cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phastBias
label: phast_phastbias
doc: "Identify regions of the alignment which are affected by GC-biased gene conversion (gBGC),\
  \ indicated by a cluster of weak-to-strong substitutions amidst a deficit of strong-to-weak\
  \ substitutions on a particular branch of the tree, with a four-state phylo-HMM.\n\nTool\
  \ homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: bgc
    type:
      - 'null'
      - float
    doc: Strength of gBGC (B parameter, > 0). Default 3.
    inputBinding:
      position: 1
      prefix: --bgc
  - id: estimate_bgc
    type:
      - 'null'
      - int
    doc: Use 1 to estimate B by maximum likelihood. Default 0.
    inputBinding:
      position: 1
      prefix: --estimate-bgc
  - id: bgc_exp_length
    type:
      - 'null'
      - float
    doc: Prior expected length of gBGC tracts. Default 1000.
    inputBinding:
      position: 1
      prefix: --bgc-exp-length
  - id: estimate_bgc_exp_length
    type:
      - 'null'
      - int
    doc: Use 1 to estimate the expected gBGC tract length by EM. Default 0.
    inputBinding:
      position: 1
      prefix: --estimate-bgc-exp-length
  - id: bgc_target_coverage
    type:
      - 'null'
      - float
    doc: Prior for gBGC tract coverage (fraction between 0 and 1). Default 0.01.
    inputBinding:
      position: 1
      prefix: --bgc-target-coverage
  - id: estimate_bgc_target_coverage
    type:
      - 'null'
      - int
    doc: Use 0 to hold gBGC target coverage constant. Default 1.
    inputBinding:
      position: 1
      prefix: --estimate-bgc-target-coverage
  - id: rho
    type:
      - 'null'
      - float
    doc: Scaling factor for branch lengths in conserved states (0-1). Default 0.31.
    inputBinding:
      position: 1
      prefix: --rho
  - id: cons_exp_length
    type:
      - 'null'
      - float
    doc: Prior expected length of conserved elements. Default 45.
    inputBinding:
      position: 1
      prefix: --cons-exp-length
  - id: cons_target_coverage
    type:
      - 'null'
      - float
    doc: Prior for coverage of conserved elements (0-1). Default 0.3.
    inputBinding:
      position: 1
      prefix: --cons-target-coverage
  - id: scale
    type:
      - 'null'
      - float
    doc: Overall scaling factor for the branch lengths in all states. Default 1.
    inputBinding:
      position: 1
      prefix: --scale
  - id: estimate_scale
    type:
      - 'null'
      - int
    doc: Use 1 to rescale branches by a maximum-likelihood scaling factor. Default 0.
    inputBinding:
      position: 1
      prefix: --estimate-scale
  - id: eqfreqs_from_msa
    type:
      - 'null'
      - int
    doc: Use 1 to reset equilibrium frequencies from the alignment. Default 1.
    inputBinding:
      position: 1
      prefix: --eqfreqs-from-msa
  - id: output_tracts
    type:
      - 'null'
      - string
    doc: Write a GFF file of regions with posterior probability of a gBGC state > 0.5.
    inputBinding:
      position: 1
      prefix: --output-tracts
  - id: posteriors
    type:
      - 'null'
      - string
    doc: 'Posterior probability output to stdout: none, wig or full. Default wig.'
    inputBinding:
      position: 1
      prefix: --posteriors
  - id: output_mods
    type:
      - 'null'
      - string
    doc: Write the tree models for all four states with this output root.
    inputBinding:
      position: 1
      prefix: --output-mods
  - id: informative_fn
    type:
      - 'null'
      - string
    doc: Write a GFF of regions of the alignment informative for gBGC.
    inputBinding:
      position: 1
      prefix: --informative-fn
  - id: informative_only
    type:
      - 'null'
      - boolean
    doc: (With --informative-fn) Print the informative regions, then quit.
    inputBinding:
      position: 1
      prefix: --informative-only
  - id: alignment
    type: File
    doc: Alignment file (any format PHAST reads).
    inputBinding:
      position: 2
  - id: neutral_mod
    type: File
    doc: Neutral model in .mod format (from phyloFit).
    inputBinding:
      position: 3
  - id: foreground_branch
    type: string
    doc: Branch of the tree to test (internal branches can be named with tree_doctor --name-ancestors).
    inputBinding:
      position: 4
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the posterior output file (standard output).
    default: scores.wig
outputs:
  - id: scores
    type: File
    doc: Posterior probabilities of gBGC (wig or full table).
    outputBinding:
      glob: $(inputs.output_name)
  - id: tracts
    type:
      - 'null'
      - File
    doc: gBGC tracts in GFF.
    outputBinding:
      glob: $(inputs.output_tracts)
  - id: mods
    type:
      type: array
      items: File
    doc: Tree models for the four states.
    outputBinding:
      glob: $(inputs.output_mods).*.mod
  - id: informative
    type:
      - 'null'
      - File
    doc: Informative regions in GFF.
    outputBinding:
      glob: $(inputs.informative_fn)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
stdout: $(inputs.output_name)
