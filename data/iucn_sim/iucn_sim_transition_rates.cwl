cwlVersion: v1.2
class: CommandLineTool
baseCommand: iucn_sim transition_rates
label: iucn_sim_transition_rates
doc: "MCMC-estimation of status transition rates from IUCN record\n\nTool homepage:
  https://github.com/tobiashofmann88/iucn_extinction_simulator"
inputs:
  - id: burnin
    type:
      - 'null'
      - int
    doc: Burn-in for MCMC for transition rate estimation (default=1000).
    default: 1000
    inputBinding:
      position: 101
      prefix: --burnin
  - id: extinction_probs_mode
    type:
      - 'null'
      - int
    doc: Set to '0' to use the critE EX mode to determine extinction 
      probabilities for each status (e.g. Mooers et al, 2008 approach). Set to 
      '1' to use empirical EX mode, based on the recorded extinction in the IUCN
      history of the reference group (e.g. Monroe et al, 2019 approach). GL data
      can only be used in the critE EX mode ('0').
    inputBinding:
      position: 101
      prefix: --extinction_probs_mode
  - id: iucn_history
    type: File
    doc: File containing IUCN history of the reference group for transition rate
      estimation ('*_iucn_history.txt' output of get_iucn_data function).
    inputBinding:
      position: 101
      prefix: --iucn_history
  - id: n_gen
    type:
      - 'null'
      - int
    doc: Number of generations for MCMC for transition rate estimation 
      (default=100000).
    default: 100000
    inputBinding:
      position: 101
      prefix: --n_gen
  - id: possibly_extinct_list
    type:
      - 'null'
      - File
    doc: File containing list of taxa that are likely extinct, but that are 
      listed as extant in IUCN, including the year of their assessment as 
      possibly extinct ('possibly_extinct_reference_taxa.txt' output from 
      get_iucn_data function). These species will then be modeled as extinct by 
      the esimate_rates function, which will effect the estimated extinction 
      probabilities when chosing `--extinction_probs_mode 1`
    inputBinding:
      position: 101
      prefix: --possibly_extinct_list
  - id: rate_samples
    type:
      - 'null'
      - int
    doc: How many rates to sample from the posterior transition rate estimates. 
      These rates will be used to populate transition rate q-matrices for 
      downstream simulations. Later on you can still chose to run more 
      simulation replicates than the here specified number of produced 
      transition rate q-matrices, in which case the `run_sim` function will 
      randomely resample from the available q-matrices (default=100, this is 
      ususally sufficient, larger numbers can lead to very high output file size
      volumes).
    default: 100
    inputBinding:
      position: 101
      prefix: --rate_samples
  - id: seed
    type:
      - 'null'
      - int
    doc: Set starting seed for the MCMC.
    inputBinding:
      position: 101
      prefix: --seed
  - id: species_data
    type: File
    doc: File containing species list and current IUCN status of species, as 
      well as generation length (GL) data estimates if available. GL data is 
      only used for '--extinction_probs_mode 0' ('species_data.txt' output from 
      get_iucn_data function).
    inputBinding:
      position: 101
      prefix: --species_data
  - id: species_specific_regression
    type:
      - 'null'
      - boolean
    doc: Enables species-specific regression fitting to model LC, NT, and VU 
      extinction probabilities. Only applicable with --extinction_probs_mode 0 
      (critE mode) and if GL is provided.
    inputBinding:
      position: 101
      prefix: --species_specific_regression
outputs:
  - id: outdir
    type: Directory
    doc: Provide path to outdir where results will be saved.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iucn_sim:2.2.0--pyr40_0
