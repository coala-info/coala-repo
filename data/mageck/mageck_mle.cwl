cwlVersion: v1.2
class: CommandLineTool
baseCommand: mageck mle
label: mageck_mle
doc: "Maximum Likelihood Estimation (MLE) module for MAGeCK.\n\nTool homepage: http://mageck.sourceforge.net"
inputs:
  - id: adjust_method
    type:
      - 'null'
      - string
    doc: Method for sgrna-level p-value adjustment, including false discovery 
      rate (fdr), holm's method (holm), or pounds's method (pounds).
    inputBinding:
      position: 101
      prefix: --adjust-method
  - id: bayes
    type:
      - 'null'
      - boolean
    doc: Use the experimental Bayes module to estimate gene essentiality
    inputBinding:
      position: 101
      prefix: --bayes
  - id: beta_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the labels of the variables (i.e., beta), if the design matrix 
      is not given by file in the --design-matrix option. Should be separated by
      ",", and the number of labels must equal to (# columns of design matrix), 
      including baseline labels.
    default: bata_0,beta_1,beta_2,...
    inputBinding:
      position: 101
      prefix: --beta-labels
  - id: cell_line
    type:
      - 'null'
      - string
    doc: The name of the cell line to be used for copy number variation 
      normalization. Must match one of the column names in the file provided by 
      --cnv-norm. This option will overwrite the default case where cell line 
      names are inferred from the columns of the design matrix.
    inputBinding:
      position: 101
      prefix: --cell-line
  - id: cnv_est
    type:
      - 'null'
      - File
    doc: Estimate CNV profiles from screening data. A BED file with gene 
      positions are required as input. The CNVs of these genes are to be 
      estimated and used for copy number bias correction.
    inputBinding:
      position: 101
      prefix: --cnv-est
  - id: cnv_norm
    type:
      - 'null'
      - File
    doc: A matrix of copy number variation data across cell lines to normalize 
      CNV-biased sgRNA scores prior to gene ranking.
    inputBinding:
      position: 101
      prefix: --cnv-norm
  - id: control_gene
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of genes whose sgRNAs are used as control sgRNAs for 
      normalization and for generating the null distribution of RRA.
    inputBinding:
      position: 101
      prefix: --control-gene
  - id: control_sgrna
    type:
      - 'null'
      - type: array
        items: string
    doc: A list of control sgRNAs for normalization and for generating the null 
      distribution of RRA.
    inputBinding:
      position: 101
      prefix: --control-sgrna
  - id: count_table
    type: File
    doc: Provide a tab-separated count table. Each line in the table should 
      include sgRNA name (1st column), target gene (2nd column) and read counts 
      in each sample.
    inputBinding:
      position: 101
      prefix: --count-table
  - id: day0_label
    type:
      - 'null'
      - string
    doc: Specify the label for control sample (usually day 0 or plasmid). For 
      every other sample label, the MLE module will treat it as a single 
      condition and generate an corresponding design matrix.
    inputBinding:
      position: 101
      prefix: --day0-label
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode to output detailed information of the running.
    inputBinding:
      position: 101
      prefix: --debug
  - id: debug_gene
    type:
      - 'null'
      - string
    doc: Debug mode to only run one gene with specified ID.
    inputBinding:
      position: 101
      prefix: --debug-gene
  - id: design_matrix
    type:
      - 'null'
      - File
    doc: Provide a design matrix, either a file name or a quoted string of the 
      design matrix. For example, "1,1;1,0". The row of the design matrix must 
      match the order of the samples in the count table (if --include- samples 
      is not specified), or the order of the samples by the --include-samples 
      option.
    inputBinding:
      position: 101
      prefix: --design-matrix
  - id: genes_varmodeling
    type:
      - 'null'
      - int
    doc: The number of genes for mean-variance modeling.
    default: 0
    inputBinding:
      position: 101
      prefix: --genes-varmodeling
  - id: include_samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the sample labels if the design matrix is not given by file in 
      the --design-matrix option. Sample labels are separated by ",", and must 
      match the labels in the count table.
    inputBinding:
      position: 101
      prefix: --include-samples
  - id: max_sgrnapergene_permutation
    type:
      - 'null'
      - int
    doc: Do not calculate beta scores or p vales if the number of sgRNAs per 
      gene is greater than this number. This will save a lot of time if some 
      isolated regions are targeted by a large number of sgRNAs (usually 
      hundreds). Must be an integer.
    default: 40
    inputBinding:
      position: 101
      prefix: --max-sgrnapergene-permutation
  - id: negative_control
    type:
      - 'null'
      - type: array
        items: string
    doc: The gene name of negative controls. The corresponding sgRNA will be 
      viewed independently.
    inputBinding:
      position: 101
      prefix: --negative-control
  - id: no_permutation_by_group
    type:
      - 'null'
      - boolean
    doc: By default, gene permutation is performed separately, by their number 
      of sgRNAs. Turning this option will perform permutation on all genes 
      together. This makes the program faster, but the p value estimation is 
      accurate only if the number of sgRNAs per gene is approximately the same.
    inputBinding:
      position: 101
      prefix: --no-permutation-by-group
  - id: norm_method
    type:
      - 'null'
      - string
    doc: Method for normalization, including "none" (no normalization), "median"
      (median normalization, default), "total" (normalization by total read 
      counts), "control" (normalization by control sgRNAs specified by the 
      --control-sgrna option).
    default: median
    inputBinding:
      position: 101
      prefix: --norm-method
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: The prefix of the output file(s).
    default: sample1
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: permutation_round
    type:
      - 'null'
      - int
    doc: 'The rounds for permutation (interger). The permutation time is (# genes)*x
      for x rounds of permutation. Suggested value: 10 (may take longer time).'
    default: 2
    inputBinding:
      position: 101
      prefix: --permutation-round
  - id: ppi_prior
    type:
      - 'null'
      - boolean
    doc: Specify whether you want to incorporate PPI as prior
    inputBinding:
      position: 101
      prefix: --PPI-prior
  - id: ppi_weighting
    type:
      - 'null'
      - float
    doc: The weighting used to calculate PPI prior. If not provided, iterations 
      will be used.
    inputBinding:
      position: 101
      prefix: --PPI-weighting
  - id: remove_outliers
    type:
      - 'null'
      - boolean
    doc: Try to remove outliers. Turning this option on will slow the algorithm.
    inputBinding:
      position: 101
      prefix: --remove-outliers
  - id: sgrna_eff_name_column
    type:
      - 'null'
      - int
    doc: The sgRNA ID column in sgRNA efficiency prediction file (specified by 
      the --sgrna-efficiency option). Default is 0 (the first column).
    default: 0
    inputBinding:
      position: 101
      prefix: --sgrna-eff-name-column
  - id: sgrna_eff_score_column
    type:
      - 'null'
      - int
    doc: The sgRNA efficiency prediction column in sgRNA efficiency prediction 
      file (specified by the --sgrna-efficiency option). Default is 1 (the 
      second column).
    default: 1
    inputBinding:
      position: 101
      prefix: --sgrna-eff-score-column
  - id: sgrna_efficiency
    type:
      - 'null'
      - File
    doc: An optional file of sgRNA efficiency prediction. The efficiency 
      prediction will be used as an initial guess of the probability an sgRNA is
      efficient. Must contain at least two columns, one containing sgRNA ID, the
      other containing sgRNA efficiency prediction.
    inputBinding:
      position: 101
      prefix: --sgrna-efficiency
  - id: threads
    type:
      - 'null'
      - int
    doc: Using multiple threads to run the algorithm. Default using only 1 
      thread.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: update_efficiency
    type:
      - 'null'
      - boolean
    doc: Iteratively update sgRNA efficiency during EM iteration.
    inputBinding:
      position: 101
      prefix: --update-efficiency
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mageck:0.5.9.5--py310h184ae93_8
stdout: mageck_mle.out
