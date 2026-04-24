cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphy_meme
label: hyphy_meme
doc: "Available analysis command line options\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: alignment
    type: File
    doc: An in-frame codon alignment in one of the formats supported by HyPhy
    inputBinding:
      position: 101
      prefix: --alignment
  - id: branches
    type:
      - 'null'
      - string
    doc: Branches to test
    inputBinding:
      position: 101
      prefix: --branches
  - id: code
    type:
      - 'null'
      - string
    doc: Which genetic code should be used
    inputBinding:
      position: 101
      prefix: --code
  - id: full_model
    type:
      - 'null'
      - string
    doc: Perform branch length re-optimization under the full codon model
    inputBinding:
      position: 101
      prefix: --full-model
  - id: impute_states
    type:
      - 'null'
      - string
    doc: Use site-level model fits to impute likely character states for each 
      sequence
    inputBinding:
      position: 101
      prefix: --impute-states
  - id: intermediate_fits
    type:
      - 'null'
      - File
    doc: Use/save parameter estimates from 'initial-guess' model fits to a JSON 
      file (default is not to save)
    inputBinding:
      position: 101
      prefix: --intermediate-fits
  - id: kill_zero_lengths
    type:
      - 'null'
      - string
    doc: Automatically delete internal zero-length branches for computational 
      efficiency (will not affect results otherwise)
    inputBinding:
      position: 101
      prefix: --kill-zero-lengths
  - id: limit_to_sites
    type:
      - 'null'
      - string
    doc: Only analyze sites whose 1-based indices match the following list (null
      to skip)
    inputBinding:
      position: 101
      prefix: --limit-to-sites
  - id: multiple_hits
    type:
      - 'null'
      - string
    doc: Include support for multiple nucleotide substitutions
    inputBinding:
      position: 101
      prefix: --multiple-hits
  - id: precision
    type:
      - 'null'
      - string
    doc: Optimization precision settings for preliminary fits
    inputBinding:
      position: 101
      prefix: --precision
  - id: pvalue
    type:
      - 'null'
      - float
    doc: The p-value threshold to use when testing for selection
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: rates
    type:
      - 'null'
      - int
    doc: The number omega rate classes to include in the model [2-4]
    inputBinding:
      position: 101
      prefix: --rates
  - id: resample
    type:
      - 'null'
      - int
    doc: '[Advanced setting, will result in MUCH SLOWER run time] Perform parametric
      bootstrap resampling to derive site-level null LRT distributions up to this
      many replicates per site. Recommended use for small to medium (<30 sequences)
      datasets'
    inputBinding:
      position: 101
      prefix: --resample
  - id: save_lf_for_sites
    type:
      - 'null'
      - string
    doc: For sites whose 1-based indices match the following list, write out 
      likelihood function snapshots (null to skip)
    inputBinding:
      position: 101
      prefix: --save-lf-for-sites
  - id: site_multihit
    type:
      - 'null'
      - string
    doc: Estimate multiple hit rates for each site
    inputBinding:
      position: 101
      prefix: --site-multihit
  - id: tree
    type:
      - 'null'
      - File
    doc: A phylogenetic tree (optionally annotated with {})
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write the resulting JSON to this file (default is to save to the same 
      path as the alignment file + 'MEME.json')
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
