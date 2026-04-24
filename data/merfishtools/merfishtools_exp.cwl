cwlVersion: v1.2
class: CommandLineTool
baseCommand: merfishtools exp
label: merfishtools_exp
doc: "Estimate expressions for each feature (e.g. gene or transcript) in each cell.\n\
  \nTool homepage: https://merfishtools.github.io"
inputs:
  - id: codebook_tsv
    type: File
    doc: "Path to codebook definition consisting of tab separated columns: feature,
      codeword.\n                      Misidentification probes (see Chen et al. Science
      2015) should not be contained in the\n                      codebook."
    inputBinding:
      position: 1
  - id: readouts
    type: File
    doc: "Raw readout data containing molecule assignments to positions.\n       \
      \               If given as TSV file (ending on .tsv), the following columns
      are expected:\n                      \n                      cell\n        \
      \              feature\n                      hamming_dist\n               \
      \       cell_position_x\n                      cell_position_y\n           \
      \           rna_position_x\n                      rna_position_y\n         \
      \             \n                      Otherwise, the official MERFISH binary
      format is expected."
    inputBinding:
      position: 2
  - id: cells
    type:
      - 'null'
      - string
    doc: Regular expression to select cells from cell column (see above).
    inputBinding:
      position: 103
      prefix: --cells
  - id: p0
    type:
      - 'null'
      - type: array
        items: float
    doc: Prior probability of 0->1 error
    inputBinding:
      position: 103
      prefix: --p0
  - id: p1
    type:
      - 'null'
      - type: array
        items: float
    doc: Prior probability of 1->0 error
    inputBinding:
      position: 103
      prefix: --p1
  - id: pmf_window_width
    type:
      - 'null'
      - int
    doc: Width of the window to calculate PMF for.
    inputBinding:
      position: 103
      prefix: --pmf-window-width
  - id: seed
    type: int
    doc: Seed for shuffling that occurs in EM algorithm.
    inputBinding:
      position: 103
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: estimate_output
    type:
      - 'null'
      - File
    doc: "Path to write expected value and standard deviation estimates of expression
      to.\n                                     Output is formatted into columns:
      cell, feature, expected value, standard deviation"
    outputBinding:
      glob: $(inputs.estimate_output)
  - id: stats_output
    type:
      - 'null'
      - File
    doc: "Path to write global statistics per cell to.\n                         \
      \            Output is formatted into columns: cell, noise-rate"
    outputBinding:
      glob: $(inputs.stats_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merfishtools:1.5.0--py312h9d36253_3
