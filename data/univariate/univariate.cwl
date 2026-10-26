cwlVersion: v1.2
class: CommandLineTool
label: univariate
doc: "Univariate statistics: two-sample tests (t-test and Wilcoxon rank test), analysis of variance, Kruskal-Wallis rank test, and correlation tests (Pearson or Spearman) on a variable x sample data matrix (Workflow4Metabolomics).\n\nTool homepage: https://github.com/workflow4metabolomics/univariate"
inputs:
  - id: data_matrix_in
    type: File
    doc: Data matrix file (variable x sample, decimal '.', missing NA, tab separated)
    inputBinding:
      position: 1
      prefix: dataMatrix_in
  - id: sample_metadata_in
    type: File
    doc: Sample metadata file (sample x metadata, tab separated)
    inputBinding:
      position: 2
      prefix: sampleMetadata_in
  - id: variable_metadata_in
    type: File
    doc: Variable metadata file (variable x metadata, tab separated)
    inputBinding:
      position: 3
      prefix: variableMetadata_in
  - id: fac_c
    type: string
    doc: Name of the column of the sample metadata table with the factor of interest (qualitative or quantitative)
    inputBinding:
      position: 4
      prefix: facC
  - id: tes_c
    type: string
    doc: "Test: ttest, wilcoxon, anova, kruskal, pearson or spearman"
    inputBinding:
      position: 5
      prefix: tesC
  - id: adj_c
    type: string
    doc: "Method for multiple testing correction: fdr, BH, bonferroni, BY, hochberg, holm, hommel or none"
    inputBinding:
      position: 6
      prefix: adjC
  - id: thr_n
    type: float
    doc: (Corrected) p-value significance threshold, between 0 and 1
    inputBinding:
      position: 7
      prefix: thrN
  - id: variable_metadata_out_name
    type: string
    doc: Name of the output variable metadata file
    inputBinding:
      position: 8
      prefix: variableMetadata_out
  - id: figure_name
    type: string
    doc: Name of the output figure file (pdf)
    inputBinding:
      position: 9
      prefix: figure
  - id: information_name
    type: string
    doc: Name of the output information file
    inputBinding:
      position: 10
      prefix: information
outputs:
  - id: variable_metadata_out
    type: File
    doc: Output variable metadata file with the test results
    outputBinding:
      glob: $(inputs.variable_metadata_out_name)
  - id: figure
    type: File
    doc: Output figure file
    outputBinding:
      glob: $(inputs.figure_name)
  - id: information
    type: File
    doc: Output information file
    outputBinding:
      glob: $(inputs.information_name)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/univariate:phenomenal-v2.2.6_cv1.3.32
