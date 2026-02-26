cwlVersion: v1.2
class: CommandLineTool
baseCommand: mageck test
label: mageck_test
doc: "Perform differential analysis of CRISPR screens.\n\nTool homepage: http://mageck.sourceforge.net"
inputs:
  - id: additional_rra_parameters
    type:
      - 'null'
      - string
    doc: Additional arguments to run RRA. They will be appended to the command 
      line for calling RRA.
    inputBinding:
      position: 101
      prefix: --additional-rra-parameters
  - id: adjust_method
    type:
      - 'null'
      - string
    doc: Method for sgrna-level p-value adjustment, including false discovery 
      rate (fdr), holm's method (holm), or pounds's method (pounds).
    inputBinding:
      position: 101
      prefix: --adjust-method
  - id: cell_line
    type:
      - 'null'
      - string
    doc: The name of the cell line to be used for copy number variation 
      normalization. Must match one of the column names in the file provided by 
      --cnv-norm.
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
  - id: control_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample label or sample index in the count table as control experiments,
      separated by comma (,). Default is all the samples not specified in 
      treatment experiments.
    inputBinding:
      position: 101
      prefix: --control-id
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
    doc: Provide a tab-separated count table instead of sam files. Each line in 
      the table should include sgRNA name (1st column), gene name (2nd column) 
      and read counts in each sample.
    inputBinding:
      position: 101
      prefix: --count-table
  - id: day0_label
    type: string
    doc: Specify the label for control sample (usually day 0 or plasmid). For 
      every other sample label, the module will treat it as a treatment 
      condition and compare with control sample.
    inputBinding:
      position: 101
      prefix: --day0-label
  - id: gene_lfc_method
    type:
      - 'null'
      - string
    doc: Method to calculate gene log2 fold changes (LFC) from sgRNA LFCs. 
      Available methods include the median/mean of all sgRNAs (median/mean), or 
      the median/mean sgRNAs that are ranked in front of the alpha cutoff in RRA
      (alphamedian/alphamean), or the sgRNA that has the second strongest LFC 
      (secondbest). In the alphamedian/alphamean case, the number of sgRNAs 
      correspond to the "goodsgrna" column in the output, and the gene LFC will 
      be set to 0 if no sgRNA is in front of the alpha cutoff. Default median.
    default: median
    inputBinding:
      position: 101
      prefix: --gene-lfc-method
  - id: gene_test_fdr_threshold
    type:
      - 'null'
      - float
    doc: p value threshold to determine the alpha value of RRA in gene test (-p 
      option in RRA), default 0.25.
    default: 0.25
    inputBinding:
      position: 101
      prefix: --gene-test-fdr-threshold
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files.
    inputBinding:
      position: 101
      prefix: --keep-tmp
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
  - id: normcounts_to_file
    type:
      - 'null'
      - boolean
    doc: Write normalized read counts to file ([output- prefix].normalized.txt).
    inputBinding:
      position: 101
      prefix: --normcounts-to-file
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: The prefix of the output file(s). Default sample1.
    default: sample1
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Paired sample comparisons. In this mode, the number of samples in -t 
      and -c must match and have an exactly the same order in terms of samples. 
      For example, "-t treatment_r1,treatment_r2 -c control_r1,control_r2".
    inputBinding:
      position: 101
      prefix: --paired
  - id: pdf_report
    type:
      - 'null'
      - boolean
    doc: Generate pdf report of the analysis.
    inputBinding:
      position: 101
      prefix: --pdf-report
  - id: remove_zero
    type:
      - 'null'
      - string
    doc: 'Remove sgRNAs whose mean value is zero in control, treatment, both control/treatment,
      or any control/treatment sample. Default: both (remove those sgRNAs that are
      zero in both control and treatment samples).'
    default: both
    inputBinding:
      position: 101
      prefix: --remove-zero
  - id: remove_zero_threshold
    type:
      - 'null'
      - float
    doc: sgRNA normalized count threshold to be considered removed in the 
      --remove-zero option. Default 0.
    default: 0
    inputBinding:
      position: 101
      prefix: --remove-zero-threshold
  - id: skip_gene
    type:
      - 'null'
      - type: array
        items: string
    doc: Skip genes in the report. By default, "NA" or "na" will be skipped.
    inputBinding:
      position: 101
      prefix: --skip-gene
  - id: sort_criteria
    type:
      - 'null'
      - string
    doc: Sorting criteria, either by negative selection (neg) or positive 
      selection (pos). Default negative selection.
    default: neg
    inputBinding:
      position: 101
      prefix: --sort-criteria
  - id: treatment_id
    type:
      type: array
      items: string
    doc: Sample label or sample index (0 as the first sample) in the count table
      as treatment experiments, separated by comma (,). If sample label is 
      provided, the labels must match the labels in the first line of the count 
      table; for example, "HL60.final,KBM7.final". For sample index, "0,2" means
      the 1st and 3rd samples are treatment experiments.
    inputBinding:
      position: 101
      prefix: --treatment-id
  - id: variance_estimation_samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample label or sample index for estimating variances, separated by 
      comma (,). See -t/--treatment-id option for specifying samples.
    inputBinding:
      position: 101
      prefix: --variance-estimation-samples
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mageck:0.5.9.5--py310h184ae93_8
stdout: mageck_test.out
