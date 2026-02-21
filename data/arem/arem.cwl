cwlVersion: v1.2
class: CommandLineTool
baseCommand: arem
label: arem
doc: "Model-based Analysis for ChIP-Sequencing\n\nTool homepage: http://cbcl.ics.uci.edu/AREM"
inputs:
  - id: band_width
    type:
      - 'null'
      - int
    doc: Band width. This value is only used while building the shifting model.
    default: 300
    inputBinding:
      position: 101
      prefix: --bw
  - id: call_subpeaks
    type:
      - 'null'
      - boolean
    doc: If set, AREM will invoke Mali Salmon's PeakSplitter soft through system call.
    inputBinding:
      position: 101
      prefix: --call-subpeaks
  - id: control
    type:
      - 'null'
      - type: array
        items: File
    doc: Control files. When ELANDMULTIPET is selected, you must provide two files
      separated by comma.
    inputBinding:
      position: 101
      prefix: --control
  - id: diag
    type:
      - 'null'
      - boolean
    doc: Whether or not to produce a diagnosis report.
    inputBinding:
      position: 101
      prefix: --diag
  - id: em_converge_diff
    type:
      - 'null'
      - float
    doc: The minimum entropy change between iterations before halting E-M steps.
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --EM-converge-diff
  - id: em_max_score
    type:
      - 'null'
      - float
    doc: Maximum enrichment score.
    inputBinding:
      position: 101
      prefix: --EM-max-score
  - id: em_min_score
    type:
      - 'null'
      - float
    doc: Minimum enrichment score.
    default: 1.5
    inputBinding:
      position: 101
      prefix: --EM-min-score
  - id: em_show_graphs
    type:
      - 'null'
      - boolean
    doc: generate diagnostic graphs for E-M. (requires MATPLOTLIB).
    inputBinding:
      position: 101
      prefix: --EM-show-graphs
  - id: fe_max
    type:
      - 'null'
      - string
    doc: For diagnostics, max fold enrichment to consider.
    inputBinding:
      position: 101
      prefix: --fe-max
  - id: fe_min
    type:
      - 'null'
      - int
    doc: For diagnostics, min fold enrichment to consider.
    default: 0
    inputBinding:
      position: 101
      prefix: --fe-min
  - id: fe_step
    type:
      - 'null'
      - int
    doc: For diagnostics, fold enrichment step.
    default: 20
    inputBinding:
      position: 101
      prefix: --fe-step
  - id: format
    type:
      - 'null'
      - string
    doc: Format of tag file, "AUTO", "BED" or "ELAND" or "ELANDMULTI" or "ELANDMULTIPET"
      or "ELANDEXPORT" or "SAM" or "BAM" or "BOWTIE".
    default: AUTO
    inputBinding:
      position: 101
      prefix: --format
  - id: genome_size
    type:
      - 'null'
      - string
    doc: Effective genome size. It can be 1.0e+9 or shortcuts:'hs' for human, 'mm'
      for mouse, 'ce' for C. elegans and 'dm' for fruitfly.
    default: hs
    inputBinding:
      position: 101
      prefix: --gsize
  - id: keep_duplicates
    type:
      - 'null'
      - string
    doc: It controls the AREM behavior towards duplicate tags at the exact same location.
    default: auto
    inputBinding:
      position: 101
      prefix: --keep-dup
  - id: large_local
    type:
      - 'null'
      - int
    doc: The large nearby region in basepairs to calculate dynamic lambda.
    default: 10000
    inputBinding:
      position: 101
      prefix: --llocal
  - id: mfold
    type:
      - 'null'
      - string
    doc: Select the regions within MFOLD range of high-confidence enrichment ratio
      against background to build model.
    default: 10,30
    inputBinding:
      position: 101
      prefix: --mfold
  - id: name
    type:
      - 'null'
      - string
    doc: Experiment name, which will be used to generate output file names.
    default: NA
    inputBinding:
      position: 101
      prefix: --name
  - id: no_em
    type:
      - 'null'
      - boolean
    doc: Do NOT iteratively align multi-reads by E-M.
    inputBinding:
      position: 101
      prefix: --no-EM
  - id: no_greedy_caller
    type:
      - 'null'
      - boolean
    doc: Use AREM default peak caller instead of the greedy caller.
    inputBinding:
      position: 101
      prefix: --no-greedy-caller
  - id: no_lambda
    type:
      - 'null'
      - boolean
    doc: If True, AREM will use fixed background lambda as local lambda for every
      peak region.
    inputBinding:
      position: 101
      prefix: --nolambda
  - id: no_map_quals
    type:
      - 'null'
      - boolean
    doc: Do not use mapping probabilities as priors in each update step.
    inputBinding:
      position: 101
      prefix: --no-map-quals
  - id: no_model
    type:
      - 'null'
      - boolean
    doc: Whether or not to build the shifting model.
    inputBinding:
      position: 101
      prefix: --nomodel
  - id: no_multi
    type:
      - 'null'
      - boolean
    doc: Throw away all reads that have more than one alignment
    inputBinding:
      position: 101
      prefix: --no-multi
  - id: off_auto
    type:
      - 'null'
      - boolean
    doc: Whether turn off the auto pair model process.
    inputBinding:
      position: 101
      prefix: --off-auto
  - id: pet_dist
    type:
      - 'null'
      - int
    doc: Best distance between Pair-End Tags. Only available when format is 'ELANDMULTIPET'.
    default: 200
    inputBinding:
      position: 101
      prefix: --petdist
  - id: prior_snp
    type:
      - 'null'
      - float
    doc: Prior probability that a SNP occurs at any base in the genome.
    default: 0.001
    inputBinding:
      position: 101
      prefix: --prior-snp
  - id: pvalue
    type:
      - 'null'
      - float
    doc: Pvalue cutoff for peak detection.
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: quality_scale
    type:
      - 'null'
      - string
    doc: Read quality scale must be one of ['auto', 'sanger+33', 'illumina+64'].
    default: auto
    inputBinding:
      position: 101
      prefix: --quality-scale
  - id: random_multi
    type:
      - 'null'
      - boolean
    doc: Convert all multi reads to unique reads by selecting one alignment at random
      for each read.
    inputBinding:
      position: 101
      prefix: --random-multi
  - id: shift_size
    type:
      - 'null'
      - int
    doc: The arbitrary shift size in bp. When nomodel is true, AREM will use this
      value as 1/2 of fragment size.
    default: 100
    inputBinding:
      position: 101
      prefix: --shiftsize
  - id: single_profile
    type:
      - 'null'
      - boolean
    doc: When set, a single wiggle file will be saved for treatment and input.
    inputBinding:
      position: 101
      prefix: --single-profile
  - id: small_local
    type:
      - 'null'
      - int
    doc: The small nearby region in basepairs to calculate dynamic lambda.
    default: 1000
    inputBinding:
      position: 101
      prefix: --slocal
  - id: space
    type:
      - 'null'
      - int
    doc: The resoluation for saving wiggle files. Usable only with '--wig' option.
    default: 10
    inputBinding:
      position: 101
      prefix: --space
  - id: tag_size
    type:
      - 'null'
      - int
    doc: Tag size. This will overide the auto detected tag size.
    default: 25
    inputBinding:
      position: 101
      prefix: --tsize
  - id: to_small
    type:
      - 'null'
      - boolean
    doc: When set, scale the larger dataset down to the smaller dataset.
    inputBinding:
      position: 101
      prefix: --to-small
  - id: treatment
    type:
      type: array
      items: File
    doc: ChIP-seq treatment files. When ELANDMULTIPET is selected, you must provide
      two files separated by comma.
    inputBinding:
      position: 101
      prefix: --treatment
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Set verbose level. 0: critical, 1: warning, 2: process info, 3: debug.'
    default: 2
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: wig
    type:
      - 'null'
      - File
    doc: Whether or not to save extended fragment pileup at every WIGEXTEND bps into
      a wiggle file.
    outputBinding:
      glob: $(inputs.wig)
  - id: bed_graph
    type:
      - 'null'
      - File
    doc: Whether or not to save extended fragment pileup at every bp into a bedGraph
      file.
    outputBinding:
      glob: $(inputs.bed_graph)
  - id: write_read_probs
    type:
      - 'null'
      - File
    doc: Write out all final reads, including their alignment probabilities as a BED
      file.
    outputBinding:
      glob: $(inputs.write_read_probs)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arem:1.0.1--py27_0
