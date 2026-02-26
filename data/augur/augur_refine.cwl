cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur refine
label: augur_refine
doc: "Refine an initial tree using sequence metadata.\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: alignment
    type:
      - 'null'
      - File
    doc: alignment in fasta or VCF format
    default: None
    inputBinding:
      position: 101
      prefix: --alignment
  - id: branch_length_inference
    type:
      - 'null'
      - string
    doc: branch length mode of treetime to use
    default: auto
    inputBinding:
      position: 101
      prefix: --branch-length-inference
  - id: clock_filter_iqd
    type:
      - 'null'
      - float
    doc: 'clock-filter: remove tips that deviate more than n_iqd interquartile ranges
      from the root-to-tip vs time regression'
    default: None
    inputBinding:
      position: 101
      prefix: --clock-filter-iqd
  - id: clock_rate
    type:
      - 'null'
      - float
    doc: fixed clock rate
    default: None
    inputBinding:
      position: 101
      prefix: --clock-rate
  - id: clock_std_dev
    type:
      - 'null'
      - float
    doc: standard deviation of the fixed clock_rate estimate
    default: None
    inputBinding:
      position: 101
      prefix: --clock-std-dev
  - id: coalescent
    type:
      - 'null'
      - string
    doc: coalescent time scale in units of inverse clock rate (float), optimize 
      as scalar ('opt'), or skyline ('skyline')
    default: None
    inputBinding:
      position: 101
      prefix: --coalescent
  - id: covariance
    type:
      - 'null'
      - boolean
    doc: Account for covariation when estimating rates and/or rerooting. Use 
      --no-covariance to turn off.
    default: true
    inputBinding:
      position: 101
      prefix: --covariance
  - id: date_confidence
    type:
      - 'null'
      - boolean
    doc: calculate confidence intervals for node dates
    default: false
    inputBinding:
      position: 101
      prefix: --date-confidence
  - id: date_format
    type:
      - 'null'
      - string
    doc: date format
    default: '%Y-%m-%d'
    inputBinding:
      position: 101
      prefix: --date-format
  - id: date_inference
    type:
      - 'null'
      - string
    doc: assign internal nodes to their marginally most likely dates, not 
      jointly most likely
    default: joint
    inputBinding:
      position: 101
      prefix: --date-inference
  - id: divergence_units
    type:
      - 'null'
      - string
    doc: Units in which sequence divergences is exported.
    default: mutations-per-site
    inputBinding:
      position: 101
      prefix: --divergence-units
  - id: gen_per_year
    type:
      - 'null'
      - int
    doc: number of generations per year, relevant for skyline output('skyline')
    default: 50
    inputBinding:
      position: 101
      prefix: --gen-per-year
  - id: greedy_resolve
    type:
      - 'null'
      - boolean
    doc: Resolve polytomies via greedy optimization
    inputBinding:
      position: 101
      prefix: --greedy-resolve
  - id: keep_ids
    type:
      - 'null'
      - File
    doc: file containing ids to keep in tree regardless of clock filtering (one 
      per line)
    default: None
    inputBinding:
      position: 101
      prefix: --keep-ids
  - id: keep_polytomies
    type:
      - 'null'
      - boolean
    doc: Do not attempt to resolve polytomies
    default: false
    inputBinding:
      position: 101
      prefix: --keep-polytomies
  - id: keep_root
    type:
      - 'null'
      - boolean
    doc: do not reroot the tree; use it as-is. Overrides anything specified by 
      --root.
    default: false
    inputBinding:
      position: 101
      prefix: --keep-root
  - id: max_iter
    type:
      - 'null'
      - int
    doc: maximal number of iterations TreeTime uses for timetree inference
    default: 2
    inputBinding:
      position: 101
      prefix: --max-iter
  - id: metadata
    type:
      - 'null'
      - File
    doc: sequence metadata
    default: None
    inputBinding:
      position: 101
      prefix: --metadata
  - id: metadata_delimiters
    type:
      - 'null'
      - type: array
        items: string
    doc: delimiters to accept when reading a metadata file. Only one delimiter 
      will be inferred.
    default:
      - ','
      - "\t"
    inputBinding:
      position: 101
      prefix: --metadata-delimiters
  - id: metadata_id_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: names of possible metadata columns containing identifier information, 
      ordered by priority. Only one ID column will be inferred.
    default:
      - strain
      - name
    inputBinding:
      position: 101
      prefix: --metadata-id-columns
  - id: no_covariance
    type:
      - 'null'
      - boolean
    doc: Turn off covariance accounting.
    inputBinding:
      position: 101
      prefix: --no-covariance
  - id: precision
    type:
      - 'null'
      - int
    doc: precision used by TreeTime to determine the number of grid points that 
      are used for the evaluation of the branch length interpolation objects. 
      Values range from 0 (rough) to 3 (ultra fine) and default to 'auto'.
    default: None
    inputBinding:
      position: 101
      prefix: --precision
  - id: remove_outgroup
    type:
      - 'null'
      - boolean
    doc: Remove the outgroup supplied via '--root'This is only valid when a 
      single strain name has been supplied as the root.
    default: false
    inputBinding:
      position: 101
      prefix: --remove-outgroup
  - id: root
    type:
      - 'null'
      - type: array
        items: string
    doc: rooting mechanism ('best', 'least-squares', 'min_dev', 'oldest', 
      'mid_point') OR node to root by OR two nodes indicating a monophyletic 
      group to root by. Run treetime -h for definitions of rooting methods.
    default:
      - best
    inputBinding:
      position: 101
      prefix: --root
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for random number generation
    default: None
    inputBinding:
      position: 101
      prefix: --seed
  - id: stochastic_resolve
    type:
      - 'null'
      - boolean
    doc: Resolve polytomies via stochastic subtree building rather than greedy 
      optimization
    default: false
    inputBinding:
      position: 101
      prefix: --stochastic-resolve
  - id: timetree
    type:
      - 'null'
      - boolean
    doc: produce timetree using treetime, requires tree where branch length is 
      in units of average number of nucleotide or protein substitutions per site
      (and branch lengths do not exceed 4)
    default: false
    inputBinding:
      position: 101
      prefix: --timetree
  - id: tree
    type: File
    doc: prebuilt Newick
    default: None
    inputBinding:
      position: 101
      prefix: --tree
  - id: use_fft
    type:
      - 'null'
      - boolean
    doc: produce timetree using FFT for convolutions
    default: false
    inputBinding:
      position: 101
      prefix: --use-fft
  - id: vcf_reference
    type:
      - 'null'
      - File
    doc: fasta file of the sequence the VCF was mapped to
    default: None
    inputBinding:
      position: 101
      prefix: --vcf-reference
  - id: verbosity
    type:
      - 'null'
      - int
    doc: treetime verbosity, between 0 and 6 (higher values more output)
    default: 1
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: year_bounds
    type:
      - 'null'
      - type: array
        items: string
    doc: specify min or max & min prediction bounds for samples with XX in year
    default: None
    inputBinding:
      position: 101
      prefix: --year-bounds
outputs:
  - id: output_tree
    type:
      - 'null'
      - File
    doc: file name to write tree to
    outputBinding:
      glob: $(inputs.output_tree)
  - id: output_node_data
    type:
      - 'null'
      - File
    doc: file name to write branch lengths as node data
    outputBinding:
      glob: $(inputs.output_node_data)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
