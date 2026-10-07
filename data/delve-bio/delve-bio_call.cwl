cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - delve
  - call
label: delve-bio_call
doc: "Call variants from a BAM file\n\nTool homepage: https://github.com/berndbohmeier/delve"
inputs:
  - id: bamfile
    type: File
    doc: "BAM file (indexed)"
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .csi
        required: false
    inputBinding:
      position: 1
  - id: fasta_ref
    type: File
    doc: "Reference FASTA file (indexed)"
    secondaryFiles:
      - .fai
    inputBinding:
      position: 101
      prefix: --fasta-ref
  - id: regions_file
    type:
      - 'null'
      - File
    doc: "Regions file"
    inputBinding:
      position: 101
      prefix: --regions-file
  - id: region
    type:
      - 'null'
      - string
    doc: "Region string"
    inputBinding:
      position: 101
      prefix: --region
  - id: sample_name
    type:
      - 'null'
      - string
    doc: "Sample name [default: sample]"
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: output
    type:
      - 'null'
      - string
    doc: "Output file"
    inputBinding:
      position: 101
      prefix: --output
  - id: min_mq
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality [default: 0]"
    inputBinding:
      position: 101
      prefix: --min-MQ
  - id: min_bq
    type:
      - 'null'
      - int
    doc: "Minimum base quality [default: 20]"
    inputBinding:
      position: 101
      prefix: --min-BQ
  - id: min_cov
    type:
      - 'null'
      - int
    doc: "Minimum coverage [default: 10]"
    inputBinding:
      position: 101
      prefix: --min-cov
  - id: max_cov
    type:
      - 'null'
      - int
    doc: "Maximum coverage [default: 5000]"
    inputBinding:
      position: 101
      prefix: --max-cov
  - id: truncate_regions
    type:
      - 'null'
      - int
    doc: "Minimum VAF Truncate regions [default: 0]"
    inputBinding:
      position: 101
      prefix: --truncate-regions
  - id: compute_baq
    type:
      - 'null'
      - boolean
    doc: "Compute BAQ"
    inputBinding:
      position: 101
      prefix: --compute-baq
  - id: strand_bias_odds_ratio
    type:
      - 'null'
      - float
    doc: "Strand bias odds ratio [default: 7]"
    inputBinding:
      position: 101
      prefix: --strand-bias-odds-ratio
  - id: deletion_filter_threshold
    type:
      - 'null'
      - float
    doc: "Deletion filter threshold. Positions with higher ratio of deletions will be filtered [default: 0.8]"
    inputBinding:
      position: 101
      prefix: --deletion-filter-threshold
  - id: low_qual_reads_filter_threshold
    type:
      - 'null'
      - float
    doc: "Too many low quality reads filter threshold. Positions with higher ratio of low quality reads will be filtered [default: 0.8]"
    inputBinding:
      position: 101
      prefix: --low-qual-reads-filter-threshold
  - id: model_params
    type:
      - 'null'
      - string
    doc: "Model parameters (comma-separated floats LRT_REF,LRT_ALT,H0_VAF) [default: 8.0,8.0,0.01]"
    inputBinding:
      position: 101
      prefix: --model-params
  - id: variants_only
    type:
      - 'null'
      - boolean
    doc: "Show only variants"
    inputBinding:
      position: 101
      prefix: --variants-only
  - id: apply_filters
    type:
      - 'null'
      - string
    doc: "Apply filters"
    inputBinding:
      position: 101
      prefix: --apply-filters
  - id: set_failed_gts
    type:
      - 'null'
      - string
    doc: "Set genotypes of failed samples to missing value (.) or reference (0) [possible values: 0, .]"
    inputBinding:
      position: 101
      prefix: --set-failed-GTs
outputs:
  - id: stdout
    type: stdout
    doc: Variant calls (VCF) when no output file is given
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/delve-bio:0.2.0--h4349ce8_0
stdout: delve-bio_call.vcf
