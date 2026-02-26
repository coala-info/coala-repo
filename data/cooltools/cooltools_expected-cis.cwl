cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - expected-cis
label: cooltools_expected-cis
doc: "Calculate expected Hi-C signal for cis regions of chromosomal interaction\n\
  \  map: average of interactions separated by the same genomic distance, i.e.\n \
  \ are on the same diagonal on the cis-heatmap.\n\n  When balancing weights are not
  applied to the data, there is no masking of\n  bad bins performed.\n\nTool homepage:
  https://github.com/mirnylab/cooltools"
inputs:
  - id: cool_path
    type: File
    doc: The paths to a .cool file with a balanced Hi-C map.
    inputBinding:
      position: 1
  - id: aggregate_smoothed
    type:
      - 'null'
      - boolean
    doc: "If set, cis-expected is averaged over all regions\n                    \
      \       and then smoothed. Result is stored in an\n                        \
      \   additional column, e.g. balanced.avg.smoothed.agg.\n                   \
      \        Ignored without smoothing"
    inputBinding:
      position: 102
      prefix: --aggregate-smoothed
  - id: chunksize
    type:
      - 'null'
      - int
    doc: "Control the number of pixels handled by each worker\n                  \
      \         process at a time."
    default: 10000000
    inputBinding:
      position: 102
      prefix: --chunksize
  - id: clr_weight_name
    type:
      - 'null'
      - string
    doc: "Use balancing weight with this name stored in\n                        \
      \   cooler.Provide empty argument to calculate cis-\n                      \
      \     expected on raw data"
    default: weight
    inputBinding:
      position: 102
      prefix: --clr-weight-name
  - id: ignore_diags
    type:
      - 'null'
      - int
    doc: Number of diagonals to neglect for cis contact type
    default: 2
    inputBinding:
      position: 102
      prefix: --ignore-diags
  - id: nproc
    type:
      - 'null'
      - int
    doc: "Number of processes to split the work\n                           between."
    default: 1
    inputBinding:
      position: 102
      prefix: --nproc
  - id: regions
    type:
      - 'null'
      - File
    doc: "Path to a 3 or 4-column BED file with genomic\n                        \
      \   regions to calculated cis-expected on. When region\n                   \
      \        names are not provided (no 4th column), UCSC-style\n              \
      \             region names are generated. Cis-expected is\n                \
      \           calculated for all chromosomes, when this is not\n             \
      \              specified. Note that '--regions' is the deprecated\n        \
      \                   name of the option. Use '--view' instead."
    inputBinding:
      position: 102
      prefix: --regions
  - id: smooth
    type:
      - 'null'
      - boolean
    doc: "If set, cis-expected is smoothed and result stored\n                   \
      \        in an additional column e.g. balanced.avg.smoothed"
    inputBinding:
      position: 102
      prefix: --smooth
  - id: smooth_sigma
    type:
      - 'null'
      - float
    doc: "Control smoothing with the standard deviation of\n                     \
      \      the smoothing Gaussian kernel, ignored without\n                    \
      \       smoothing."
    default: 0.1
    inputBinding:
      position: 102
      prefix: --smooth-sigma
  - id: view
    type:
      - 'null'
      - File
    doc: "Path to a 3 or 4-column BED file with genomic\n                        \
      \   regions to calculated cis-expected on. When region\n                   \
      \        names are not provided (no 4th column), UCSC-style\n              \
      \             region names are generated. Cis-expected is\n                \
      \           calculated for all chromosomes, when this is not\n             \
      \              specified. Note that '--regions' is the deprecated\n        \
      \                   name of the option. Use '--view' instead."
    inputBinding:
      position: 102
      prefix: --view
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "Specify output file name to store the expected in a\n                  \
      \         tsv format."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
