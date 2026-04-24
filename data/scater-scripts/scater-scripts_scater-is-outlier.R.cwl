cwlVersion: v1.2
class: CommandLineTool
baseCommand: scater-is-outlier.R
label: scater-scripts_scater-is-outlier.R
doc: "Detects outliers in a numeric QC metric for each cell.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts"
inputs:
  - id: log_transform
    type:
      - 'null'
      - boolean
    doc: logical, should the values of the metric be transformed to the log10 
      scale before computing median-absolute-deviation for outlier detection?
    inputBinding:
      position: 101
      prefix: --log
  - id: metric_file
    type: File
    doc: Two column table with cell names on the first column and numeric QC 
      metric on the second column.
    inputBinding:
      position: 101
      prefix: --metric-file
  - id: min_diff
    type:
      - 'null'
      - float
    doc: numeric scalar indicating the minimum difference from the median to 
      consider as an outlier. The outlier threshold is defined from the larger 
      of nmads MADs and min.diff, to avoid calling many outliers when the MAD is
      very small. If NA, it is ignored.
    inputBinding:
      position: 101
      prefix: --min-diff
  - id: nmads
    type:
      - 'null'
      - float
    doc: scalar, number of median-absolute-deviations away from median required 
      for a value to be called an outlier.
    inputBinding:
      position: 101
      prefix: --nmads
  - id: type
    type:
      - 'null'
      - string
    doc: 'character scalar, choice indicate whether outliers should be looked for
      at both tails (default: "both") or only at the lower end ("lower") or the higher
      end ("higher").'
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File name in which to store the output vector of outliers (one value 
      per line)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scater-scripts:0.0.5--0
