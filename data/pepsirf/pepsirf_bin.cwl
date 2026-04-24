cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pepsirf
  - bin
label: pepsirf_bin
doc: "The bin module is used to create groups of peptides with similar starting abundances
  (i.e. bins), based on the normalized read counts for >= 1 negative controls. These
  bins can be provided as an input for zscore calculations using the zscore module.\n
  \nTool homepage: https://github.com/LadnerLab/PepSIRF"
inputs:
  - id: bin_size
    type:
      - 'null'
      - int
    doc: The minimum number of peptides that a bin must contain. If a bin would be
      created with fewer than bin_size peptides, it will be combined with the next
      bin until at least bin_size peptides are found.
    inputBinding:
      position: 101
      prefix: --bin_size
  - id: round_to
    type:
      - 'null'
      - int
    doc: The 'rounding factor' for the scores parsed from the score matrix prior to
      binning. Scores found in the matrix will be rounded to the nearest 1/10^x for
      a rounding factor x.
    inputBinding:
      position: 101
      prefix: --round_to
  - id: scores
    type: File
    doc: Input tab-delimited normalized score matrix file to use for peptide binning.
      This matrix should only contain info for the negative control samples that should
      be used to generate bins. Peptides with similar scores, summed across the negative
      controls, will be binned together.
    inputBinding:
      position: 101
      prefix: --scores
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Name for the output bins file. This file will contain one bin per line and
      each bin will be a tab-delimited list of the names of the peptides in the bin.
    outputBinding:
      glob: $(inputs.output)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Designated file to which the module's processes are logged. By default, the
      logfile's name will include the module's name and the time the module started
      running.
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
