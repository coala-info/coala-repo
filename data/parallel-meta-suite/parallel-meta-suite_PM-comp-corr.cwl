cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PM-comp-corr
label: parallel-meta-suite_PM-comp-corr
doc: "Compute the correlation and network by feature table\n\nTool homepage: https://github.com/qdu-bioinfo/parallel-meta-suite"
inputs:
  - id: feature_table
    type:
      - 'null'
      - File
    doc: "Input feature table file (*.Abd); rows are samples and columns are features"
    inputBinding:
      position: 1
      prefix: "-i"
  - id: feature_table_upper
    type:
      - 'null'
      - File
    doc: "Input feature table file (*.Abd), same as -i"
    inputBinding:
      position: 1
      prefix: "-T"
  - id: meta_data
    type:
      - 'null'
      - File
    doc: "Meta data table to correlate with the features [Optional]"
    inputBinding:
      position: 1
      prefix: "-m"
  - id: selected_feature
    type:
      - 'null'
      - string
    doc: "Selected feature, separated by \",\" [Optional for -m]"
    inputBinding:
      position: 1
      prefix: "-c"
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "Output prefix, default is \"corr_matrix\""
    inputBinding:
      position: 1
      prefix: "-o"
  - id: metrics
    type:
      - 'null'
      - int
    doc: "0:(Spearman) or 1:(Pearson) metrics, default is 0"
    inputBinding:
      position: 1
      prefix: "-f"
  - id: network
    type:
      - 'null'
      - string
    doc: "Network based co-occurrence analysis, T(rue) or F(alse), default is F"
    inputBinding:
      position: 1
      prefix: "-N"
  - id: network_threshold
    type:
      - 'null'
      - float
    doc: "Network analysis threshold, default is 0.5"
    inputBinding:
      position: 1
      prefix: "-G"
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads, default is auto"
    inputBinding:
      position: 1
      prefix: "-t"
outputs:
  - id: self_matrix
    type:
      - 'null'
      - File
    doc: "Feature-feature correlation matrix"
    outputBinding:
      glob: "$(inputs.output_prefix ? inputs.output_prefix + '.self_matrix.out' : 'self_corr_matrix.out')"
  - id: corr_matrix
    type:
      - 'null'
      - File
    doc: "Correlation matrix of the features with the meta data (only with -m)"
    outputBinding:
      glob: "$(inputs.output_prefix ? inputs.output_prefix + '.corr_matrix.out' : 'corr_matrix.out')"
  - id: network_plot
    type:
      - 'null'
      - File
    doc: "Network plot (only with -N T)"
    outputBinding:
      glob: "*.network.pdf"
  - id: stdout
    type: stdout
    doc: "Standard output (screen messages)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parallel-meta-suite:1.0--h7d875b9_1
stdout: parallel-meta-suite_PM-comp-corr.out
