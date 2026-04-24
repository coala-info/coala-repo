cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pepsirf
  - zscore
label: pepsirf_zscore
doc: "The zscore module is used to calculate Z scores for each peptide in each sample.
  These Z scores represent the number of standard deviations away from the mean, with
  the mean and standard deviation both calculated separately for each bin of peptides.\n
  \nTool homepage: https://github.com/LadnerLab/PepSIRF"
inputs:
  - id: bins
    type: File
    doc: Name of the file containing bins, one bin per line, as output by the bin
      module. Each bin contains a tab-delimited list of peptide names.
    inputBinding:
      position: 101
      prefix: --bins
  - id: hdi
    type:
      - 'null'
      - float
    doc: Alternative approach for discarding outliers prior to calculating mean and
      stdev. If provided, this argument will override --trim. User should provide
      the high density interval (e.g., 0.95).
    inputBinding:
      position: 101
      prefix: --hdi
  - id: num_threads
    type:
      - 'null'
      - int
    doc: The number of threads to use for analyses.
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: scores
    type: File
    doc: Name of the file to use as input. Should be a score matrix in the format
      as output by the demux and subjoin modules. Raw or normalized read counts can
      be used.
    inputBinding:
      position: 101
      prefix: --scores
  - id: trim
    type:
      - 'null'
      - float
    doc: Percentile of lowest and highest counts within a bin to ignore when calculating
      the mean and standard deviation. This value must be in the range [0.00,100.0].
    inputBinding:
      position: 101
      prefix: --trim
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Name for the output Z scores file. This file will be a tab-delimited matrix
      file with the same dimensions as the input score file.
    outputBinding:
      glob: $(inputs.output)
  - id: nan_report
    type:
      - 'null'
      - File
    doc: Name of the file to write out information regarding peptides that are given
      a zscore of 'nan'.
    outputBinding:
      glob: $(inputs.nan_report)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Designated file to which the module's processes are logged.
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
