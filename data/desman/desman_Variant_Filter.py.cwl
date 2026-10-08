cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Variant_Filter.py
label: desman_Variant_Filter.py
doc: "Identify variant positions in a DESMAN base frequency table (contig,position,
  then A,C,G,T counts per sample) with a binomial / likelihood-ratio filter, and
  write the selected variants, base error transition matrix and per-position
  statistics as CSV files that share an output stub.\n\nTool homepage: https://github.com/chrisquince/DESMAN"
inputs:
  - id: variant_file
    type: File
    doc: input SNP frequencies
    inputBinding:
      position: 10
  - id: filter_variants
    type:
      - 'null'
      - float
    doc: binomial loge likelihood species p-value threshold for initial 
      filtering as chi2
    inputBinding:
      position: 1
      prefix: -f
  - id: max_qvalue
    type:
      - 'null'
      - float
    doc: specifies q value cut-off for variant defaults 1.0e-3
    inputBinding:
      position: 1
      prefix: -q
  - id: min_variant_freq
    type:
      - 'null'
      - float
    doc: specifies minimum variant frequency defaults 0.01
    inputBinding:
      position: 1
      prefix: -v
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: minimum coverage for sample to be included defaults 5.0
    inputBinding:
      position: 1
      prefix: -m
  - id: outlier_thresh
    type:
      - 'null'
      - float
    doc: threshold for COG filtering on median coverage outlier defaults to 2.0
    inputBinding:
      position: 1
      prefix: -t
  - id: sample_frac
    type:
      - 'null'
      - float
    doc: fraction of samples with COG coverage exceeding median outlier for 
      removal
    inputBinding:
      position: 1
      prefix: -sf
  - id: output_stub
    type: string
    doc: string specifying file stubs
    default: output
    inputBinding:
      position: 1
      prefix: -o
  - id: optimise_p
    type:
      - 'null'
      - boolean
    doc: optimise proportions in likelihood ratio test default false
    inputBinding:
      position: 1
      prefix: -p
  - id: cog_filter
    type:
      - 'null'
      - boolean
    doc: whether to apply COG filtering default false
    inputBinding:
      position: 1
      prefix: -c
  - id: random_seed
    type:
      - 'null'
      - int
    doc: specifies seed for numpy random number generator defaults to 23724839
    inputBinding:
      position: 1
      prefix: -s
outputs:
  - id: selected_variants
    type: File
    doc: Selected variant positions with their base counts (<stub>sel_var.csv)
    outputBinding:
      glob: $(inputs.output_stub)sel_var.csv
  - id: transition_matrix
    type: File
    doc: Estimated base error transition matrix (<stub>tran_df.csv)
    outputBinding:
      glob: $(inputs.output_stub)tran_df.csv
  - id: position_tables
    type: File[]
    doc: Per-position statistics (<stub>v_df.csv, p_df.csv, q_df.csv, r_df.csv)
    outputBinding:
      glob:
        - $(inputs.output_stub)v_df.csv
        - $(inputs.output_stub)p_df.csv
        - $(inputs.output_stub)q_df.csv
        - $(inputs.output_stub)r_df.csv
  - id: cog_filtered
    type:
      - 'null'
      - File
    doc: Frequencies after COG outlier filtering (<stub>cogf.csv, with -c)
    outputBinding:
      glob: $(inputs.output_stub)cogf.csv
  - id: log
    type: File
    doc: Run log (<stub>log.txt)
    outputBinding:
      glob: $(inputs.output_stub)log.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/desman:2.1--py39h4747326_10
