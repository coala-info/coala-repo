cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - fel
label: hyphy_fel
doc: "Available analysis command line options\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of threads to use (HyPhy CPU= argument).
    inputBinding:
      position: 100
      prefix: CPU=
      separate: false
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
    doc: "Branches to test. Options: 'All' (default), 'Internal', 'Leaves', 'Unlabeled',
      'fg' (labeled branches), comma-separated branch names (e.g. 'Node1,Node2'),
      or regex patterns (e.g. '/^human/i')"
    inputBinding:
      position: 101
      prefix: --branches
  - id: ci
    type:
      - 'null'
      - string
    doc: Compute profile likelihood confidence intervals for each variable site
    inputBinding:
      position: 101
      prefix: --ci
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
  - id: intermediate_fits
    type:
      - 'null'
      - string
    doc: Use/save parameter estimates from 'initial-guess' model fits to a JSON 
      file (default is not to save)
    inputBinding:
      position: 101
      prefix: --intermediate-fits
      valueFrom: "$(self.charAt(0) == '/' ? self : runtime.outdir + '/' + self)"
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
  - id: srv
    type:
      - 'null'
      - string
    doc: Include synonymous rate variation in the model
    inputBinding:
      position: 101
      prefix: --srv
  - id: tree
    type:
      - 'null'
      - File
    doc: A phylogenetic tree (optionally annotated with {})
    inputBinding:
      position: 101
      prefix: --tree
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write the resulting JSON to this file (default is to save to the same 
      path as the alignment file + 'FEL.json')
    outputBinding:
      glob: $(inputs.output_path)
  - id: intermediate_fits_file
    type:
      - 'null'
      - File
    doc: Parameter estimates from the initial-guess model fits (written to the 
      --intermediate-fits path)
    outputBinding:
      glob: $(inputs.intermediate_fits)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
