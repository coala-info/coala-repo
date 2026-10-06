cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Rscript
  - /files/biosigner/biosigner_wrapper.R
label: biosigner
doc: "Wrapper script for biosigner: molecular signature discovery from omics data
  with PLS-DA, Random Forest and SVM binary classifiers. Arguments are given as 
  name/value pairs.\n\nTool homepage: https://github.com/workflow4metabolomics/biosigner"
inputs:
  - id: data_matrix_in
    type: File
    doc: Input data matrix (variable x sample, tab separated)
    inputBinding:
      position: 1
      prefix: dataMatrix_in
  - id: sample_metadata_in
    type: File
    doc: Input sample metadata (sample x metadata, tab separated)
    inputBinding:
      position: 2
      prefix: sampleMetadata_in
  - id: variable_metadata_in
    type: File
    doc: Input variable metadata (variable x metadata, tab separated)
    inputBinding:
      position: 3
      prefix: variableMetadata_in
  - id: resp_c
    type: string
    doc: Column of the sample metadata with the two sample classes (e.g. case 
      and control)
    inputBinding:
      position: 4
      prefix: respC
  - id: method_c
    type:
      - 'null'
      - string
    doc: 'Classification method(s): all, plsda, randomforest or svm (default: all)'
    inputBinding:
      position: 5
      prefix: methodC
  - id: boot_i
    type:
      - 'null'
      - int
    doc: 'Number of bootstraps (default: 50)'
    inputBinding:
      position: 6
      prefix: bootI
  - id: tier_c
    type:
      - 'null'
      - string
    doc: 'Selection tier(s): S or A for S+A (default: S)'
    inputBinding:
      position: 7
      prefix: tierC
  - id: pval_n
    type:
      - 'null'
      - float
    doc: 'P-value threshold, between 0 and 1 (default: 0.05)'
    inputBinding:
      position: 8
      prefix: pvalN
  - id: seed_i
    type:
      - 'null'
      - int
    doc: Random seed; 0 means no seed (default 0)
    inputBinding:
      position: 9
      prefix: seedI
  - id: variable_metadata_out_name
    type:
      - 'null'
      - string
    doc: Output variable metadata file name
    default: variableMetadata_out.tsv
    inputBinding:
      position: 10
      prefix: variableMetadata_out
  - id: figure_tier_name
    type:
      - 'null'
      - string
    doc: Output tier figure file name
    default: figure_tier.pdf
    inputBinding:
      position: 11
      prefix: figure_tier
  - id: figure_boxplot_name
    type:
      - 'null'
      - string
    doc: Output boxplot figure file name
    default: figure_boxplot.pdf
    inputBinding:
      position: 12
      prefix: figure_boxplot
  - id: information_name
    type:
      - 'null'
      - string
    doc: Output information (log) file name
    default: information.txt
    inputBinding:
      position: 13
      prefix: information
outputs:
  - id: variable_metadata_out
    type: File
    doc: Variable metadata with the signature tier columns added
    outputBinding:
      glob: $(inputs.variable_metadata_out_name)
  - id: figure_tier
    type: File
    doc: Tier figure (PDF)
    outputBinding:
      glob: $(inputs.figure_tier_name)
  - id: figure_boxplot
    type: File
    doc: Boxplot figure (PDF)
    outputBinding:
      glob: $(inputs.figure_boxplot_name)
  - id: information
    type: File
    doc: Information (log) file
    outputBinding:
      glob: $(inputs.information_name)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biosigner:phenomenal-v2.2.8_cv1.4.26
