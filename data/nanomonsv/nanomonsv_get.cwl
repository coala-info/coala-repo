cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanomonsv_get
label: nanomonsv_get
doc: "nanomonsv get is a subcommand of nanomonsv. It processes tumor and control BAM/CRAM
  files to identify structural variants.\n\nTool homepage: https://github.com/friend1ws/nanomonsv"
inputs:
  - id: tumor_prefix
    type: string
    doc: Prefix of tumor data processed in parse step
    inputBinding:
      position: 1
  - id: tumor_bam
    type: File
    doc: Path to tumor alignment (BAM or CRAM) file
    inputBinding:
      position: 2
  - id: reference_fa
    type: File
    doc: Path to the reference genome sequence
    inputBinding:
      position: 3
  - id: check_read_max_num
    type:
      - 'null'
      - int
    doc: The maximum number of reads to check per breakpoint in the phase of 
      realignment validation
    default: 500
    inputBinding:
      position: 104
      prefix: --check_read_max_num
  - id: cluster_margin_size
    type:
      - 'null'
      - int
    doc: Two breakpoints are margined if they are within this threshould value
    default: 100
    inputBinding:
      position: 104
      prefix: --cluster_margin_size
  - id: control_bam
    type:
      - 'null'
      - File
    doc: Path to control alignment (BAM or CRAM) file
    inputBinding:
      position: 104
      prefix: --control_bam
  - id: control_panel_prefix
    type:
      - 'null'
      - string
    doc: Prefix of non-matched control panel data processed in merge_control 
      step
    inputBinding:
      position: 104
      prefix: --control_panel_prefix
  - id: control_prefix
    type:
      - 'null'
      - string
    doc: Prefix of matched control data processed in parse step
    inputBinding:
      position: 104
      prefix: --control_prefix
  - id: debug
    type:
      - 'null'
      - boolean
    doc: keep intermediate files
    default: false
    inputBinding:
      position: 104
      prefix: --debug
  - id: max_control_vaf
    type:
      - 'null'
      - float
    doc: Maximum allowed variant allele frequeycy for a control sample
    default: 0.03
    inputBinding:
      position: 104
      prefix: --max_control_VAF
  - id: max_control_variant_read_num
    type:
      - 'null'
      - int
    doc: Maximum allowed supporting read number for a control sample
    default: 1
    inputBinding:
      position: 104
      prefix: --max_control_variant_read_num
  - id: max_memory_minimap2
    type:
      - 'null'
      - int
    doc: Maximum memory size (Gbyte) for minimap2
    default: 2
    inputBinding:
      position: 104
      prefix: --max_memory_minimap2
  - id: max_overhang_size_thres
    type:
      - 'null'
      - int
    doc: Threshould for maximum overhang size
    default: 100
    inputBinding:
      position: 104
      prefix: --max_overhang_size_thres
  - id: max_panel_read_num
    type:
      - 'null'
      - int
    doc: Maximum allowed supporting read number for a nonmatched control sample
    default: 1
    inputBinding:
      position: 104
      prefix: --max_panel_read_num
  - id: max_panel_sample_num
    type:
      - 'null'
      - int
    doc: Maximum allowed sample number for a nonmatched control sample
    default: 0
    inputBinding:
      position: 104
      prefix: --max_panel_sample_num
  - id: median_mapq_thres
    type:
      - 'null'
      - int
    doc: Threshould for median mapping quality
    default: 20
    inputBinding:
      position: 104
      prefix: --median_mapQ_thres
  - id: min_indel_size
    type:
      - 'null'
      - int
    doc: Minimum indel size for the output
    default: 50
    inputBinding:
      position: 104
      prefix: --min_indel_size
  - id: min_tumor_vaf
    type:
      - 'null'
      - float
    doc: Minimum required variant allele frequency for a tumor sample
    default: 0.05
    inputBinding:
      position: 104
      prefix: --min_tumor_VAF
  - id: min_tumor_variant_read_num
    type:
      - 'null'
      - int
    doc: Minimum required supporting read number for a tumor sample
    default: 3
    inputBinding:
      position: 104
      prefix: --min_tumor_variant_read_num
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of parallel processes to use
    default: 1
    inputBinding:
      position: 104
      prefix: --processes
  - id: qv10
    type:
      - 'null'
      - boolean
    doc: Parameter preset for sequencing data with a base quality of around 10. 
      Recommended for ONT data called by Guppy before version 5
    inputBinding:
      position: 104
      prefix: --qv10
  - id: qv15
    type:
      - 'null'
      - boolean
    doc: Parameter preset for sequencing data with a base quality of around 15. 
      Recommended for ONT data called by Guppy version 5, 6.
    inputBinding:
      position: 104
      prefix: --qv15
  - id: qv20
    type:
      - 'null'
      - boolean
    doc: Parameter preset for sequencing data with a base quality of around 20. 
      Recommended for ONT data with Q20+ chemistry.
    inputBinding:
      position: 104
      prefix: --qv20
  - id: qv25
    type:
      - 'null'
      - boolean
    doc: Parameter preset for sequencing data with a base quality above 25. 
      Recommended for PacBio Hifi data.
    inputBinding:
      position: 104
      prefix: --qv25
  - id: simple_repeat_bed
    type:
      - 'null'
      - File
    doc: Path to simple repeat bed file
    inputBinding:
      position: 104
      prefix: --simple_repeat_bed
  - id: single_bnd
    type:
      - 'null'
      - boolean
    doc: Generate single end breakpoints
    default: false
    inputBinding:
      position: 104
      prefix: --single_bnd
  - id: sort_option
    type:
      - 'null'
      - string
    doc: Options for Linux sort command
    default: -S 1G
    inputBinding:
      position: 104
      prefix: --sort_option
  - id: sw_jump_params
    type:
      - 'null'
      - type: array
        items: string
    doc: Parameters (match score, mismatch penalty, gap penalty, insertion 
      penalty) for one-time smith-waterman algorithm
    default: '[1, 3, 3, 2]'
    inputBinding:
      position: 104
      prefix: --sw_jump_params
  - id: use_racon
    type:
      - 'null'
      - boolean
    doc: Use racon for error correction of clustered putative supporting reads
    default: false
    inputBinding:
      position: 104
      prefix: --use_racon
  - id: validation_score_ratio_thres
    type:
      - 'null'
      - float
    doc: Threshould for threshould for SV segment validation by alignment
    inputBinding:
      position: 104
      prefix: --validation_score_ratio_thres
  - id: var_read_min_mapq
    type:
      - 'null'
      - int
    doc: Threshould for mapping quality in validate step
    default: 0
    inputBinding:
      position: 104
      prefix: --var_read_min_mapq
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanomonsv:0.8.1--pyhdfd78af_0
stdout: nanomonsv_get.out
