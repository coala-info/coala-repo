cwlVersion: v1.2
class: CommandLineTool
baseCommand: ClonalFrameML
label: clonalframeml
doc: "Efficient inference of recombination in whole bacterial genomes using a maximum-likelihood approach.\n\nTool homepage: https://github.com/xavierdidelot/ClonalFrameML"
inputs:
  - id: newick_file
    type: File
    doc: Input Newick tree (rooted or unrooted) of the sequences
    inputBinding:
      position: 1
  - id: fasta_file
    type: File
    doc: Input alignment (FASTA; a file list or XMFA with -fasta_file_list / -xmfa_file)
    inputBinding:
      position: 2
  - id: output_file
    type: string
    doc: Prefix for all output files
    inputBinding:
      position: 3
  - id: em
    type:
      - 'null'
      - boolean
    doc: "Estimate parameters by a Baum-Welch expectation maximization algorithm (default true)."
    inputBinding:
      position: 101
      prefix: -em
      valueFrom: '$(self ? "true" : "false")'
  - id: embranch
    type:
      - 'null'
      - boolean
    doc: "Estimate parameters for each branch using the EM algorithm (default false)."
    inputBinding:
      position: 101
      prefix: -embranch
      valueFrom: '$(self ? "true" : "false")'
  - id: rescale_no_recombination
    type:
      - 'null'
      - boolean
    doc: "Rescale branch lengths for given sites with no recombination model (default false)."
    inputBinding:
      position: 101
      prefix: -rescale_no_recombination
      valueFrom: '$(self ? "true" : "false")'
  - id: imputation_only
    type:
      - 'null'
      - boolean
    doc: "Perform only ancestral state reconstruction and imputation (default false)."
    inputBinding:
      position: 101
      prefix: -imputation_only
      valueFrom: '$(self ? "true" : "false")'
  - id: kappa
    type:
      - 'null'
      - float
    doc: "Relative rate of transitions vs transversions in substitution model (value > 0, default 2.0)"
    inputBinding:
      position: 101
      prefix: -kappa
  - id: fasta_file_list
    type:
      - 'null'
      - boolean
    doc: "Take fasta_file to be a white-space separated file list (default false)."
    inputBinding:
      position: 101
      prefix: -fasta_file_list
      valueFrom: '$(self ? "true" : "false")'
  - id: xmfa_file
    type:
      - 'null'
      - boolean
    doc: "Take fasta_file to be an XMFA file (default false)."
    inputBinding:
      position: 101
      prefix: -xmfa_file
      valueFrom: '$(self ? "true" : "false")'
  - id: ignore_user_sites
    type:
      - 'null'
      - File
    doc: "Ignore sites listed in whitespace-separated sites_file."
    inputBinding:
      position: 101
      prefix: -ignore_user_sites
  - id: ignore_incomplete_sites
    type:
      - 'null'
      - boolean
    doc: "Ignore sites with any ambiguous bases (default false)."
    inputBinding:
      position: 101
      prefix: -ignore_incomplete_sites
      valueFrom: '$(self ? "true" : "false")'
  - id: use_incompatible_sites
    type:
      - 'null'
      - boolean
    doc: "Use homoplasious and multiallelic sites to correct branch lengths (default true)."
    inputBinding:
      position: 101
      prefix: -use_incompatible_sites
      valueFrom: '$(self ? "true" : "false")'
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: "Output the progress of the maximum likelihood routines (default false)."
    inputBinding:
      position: 101
      prefix: -show_progress
      valueFrom: '$(self ? "true" : "false")'
  - id: chromosome_name
    type:
      - 'null'
      - string
    doc: "Output importation status file in BED format using given chromosome name."
    inputBinding:
      position: 101
      prefix: -chromosome_name
  - id: min_branch_length
    type:
      - 'null'
      - float
    doc: "Minimum branch length (value > 0, default 1e-7)."
    inputBinding:
      position: 101
      prefix: -min_branch_length
  - id: reconstruct_invariant_sites
    type:
      - 'null'
      - boolean
    doc: "Reconstruct the ancestral states at invariant sites (default false)."
    inputBinding:
      position: 101
      prefix: -reconstruct_invariant_sites
      valueFrom: '$(self ? "true" : "false")'
  - id: label_uncorrected_tree
    type:
      - 'null'
      - boolean
    doc: "Regurgitate the uncorrected Newick tree with internal nodes labelled (default false)."
    inputBinding:
      position: 101
      prefix: -label_uncorrected_tree
      valueFrom: '$(self ? "true" : "false")'
  - id: prior_mean
    type:
      - 'null'
      - string
    doc: "Prior mean for R/theta, 1/delta, nu and M (default \"0.1 0.001 0.1 0.0001\")."
    inputBinding:
      position: 101
      prefix: -prior_mean
  - id: prior_sd
    type:
      - 'null'
      - string
    doc: "Prior standard deviation for R/theta, 1/delta, nu and M (default \"0.1 0.001 0.1 0.0001\")."
    inputBinding:
      position: 101
      prefix: -prior_sd
  - id: initial_values
    type:
      - 'null'
      - string
    doc: "Initial values for R/theta, 1/delta and nu (default \"0.1 0.001 0.05\")."
    inputBinding:
      position: 101
      prefix: -initial_values
  - id: guess_initial_m
    type:
      - 'null'
      - boolean
    doc: "Initialize M and nu jointly in the EM algorithms (default true)."
    inputBinding:
      position: 101
      prefix: -guess_initial_m
      valueFrom: '$(self ? "true" : "false")'
  - id: emsim
    type:
      - 'null'
      - int
    doc: "Number of simulations to estimate uncertainty in the EM results (default 0)."
    inputBinding:
      position: 101
      prefix: -emsim
  - id: embranch_dispersion
    type:
      - 'null'
      - float
    doc: "Dispersion in parameters among branches in the -embranch model (default .01)."
    inputBinding:
      position: 101
      prefix: -embranch_dispersion
  - id: output_filtered
    type:
      - 'null'
      - boolean
    doc: "Output a filtered alignment including only non-recombinant sites (default false)."
    inputBinding:
      position: 101
      prefix: -output_filtered
      valueFrom: '$(self ? "true" : "false")'
  - id: brent_tolerance
    type:
      - 'null'
      - float
    doc: "Set the tolerance of the Brent routine for -rescale_no_recombination (default .001)."
    inputBinding:
      position: 101
      prefix: -brent_tolerance
  - id: powell_tolerance
    type:
      - 'null'
      - float
    doc: "Set the tolerance of the Powell routine for -rescale_no_recombination (default .001)."
    inputBinding:
      position: 101
      prefix: -powell_tolerance
outputs:
  - id: labelled_tree
    type:
      - 'null'
      - File
    doc: Output tree with internal nodes labelled
    outputBinding:
      glob: $(inputs.output_file).labelled_tree.newick
  - id: importation_status
    type:
      - 'null'
      - File
    doc: Reconstructed recombination events
    outputBinding:
      glob: $(inputs.output_file).importation_status.txt
  - id: ml_sequence
    type:
      - 'null'
      - File
    doc: Imputed and reconstructed ancestral sequences
    outputBinding:
      glob: $(inputs.output_file).ML_sequence.fasta
  - id: position_cross_reference
    type:
      - 'null'
      - File
    doc: Map from alignment positions to ML_sequence positions
    outputBinding:
      glob: $(inputs.output_file).position_cross_reference.txt
  - id: em_results
    type:
      - 'null'
      - File
    doc: Point estimates of the EM parameters
    outputBinding:
      glob: $(inputs.output_file).em.txt
  - id: emsim_results
    type:
      - 'null'
      - File
    doc: Bootstrapped EM parameter estimates (-emsim)
    outputBinding:
      glob: $(inputs.output_file).emsim.txt
  - id: all_outputs
    type:
      type: array
      items: File
    doc: All files written with the output prefix
    outputBinding:
      glob: $(inputs.output_file).*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clonalframeml:1.13--h9948957_2
