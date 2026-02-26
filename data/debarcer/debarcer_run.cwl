cwlVersion: v1.2
class: CommandLineTool
baseCommand: debarcer_run
label: debarcer_run
doc: "Run the debarcer pipeline.\n\nTool homepage: https://github.com/oicr-gsi/debarcer"
inputs:
  - id: alt_threshold
    type:
      - 'null'
      - float
    doc: Variable position is labeled PASS if allele frequency >= alt_threshold
    inputBinding:
      position: 101
      prefix: --AlternativeThreshold
  - id: bamfile
    type:
      - 'null'
      - File
    doc: Path to the BAM file
    inputBinding:
      position: 101
      prefix: --Bamfile
  - id: base_quality_score
    type:
      - 'null'
      - int
    doc: Base quality score threshold. Bases with quality scores below the 
      threshold are not used in the consensus.
    default: 25
    inputBinding:
      position: 101
      prefix: --Quality
  - id: bedfile
    type: File
    doc: Path to the bed file
    inputBinding:
      position: 101
      prefix: --Bedfile
  - id: call
    type:
      - 'null'
      - boolean
    doc: Convert consensus files to VCF format. Default is True, becomes False 
      if used
    default: true
    inputBinding:
      position: 101
      prefix: --Call
  - id: config
    type:
      - 'null'
      - File
    doc: Path to the config file
    inputBinding:
      position: 101
      prefix: --Config
  - id: count_threshold
    type:
      - 'null'
      - int
    doc: Base count threshold in pileup column
    inputBinding:
      position: 101
      prefix: --CountThreshold
  - id: distance_threshold
    type:
      - 'null'
      - int
    doc: Hamming distance threshold for connecting parent-children umis
    inputBinding:
      position: 101
      prefix: --Distance
  - id: extension
    type:
      - 'null'
      - string
    doc: Figure format. Does not generate a report if pdf, even with -r True.
    default: png
    inputBinding:
      position: 101
      prefix: --Extension
  - id: famsize
    type:
      - 'null'
      - string
    doc: Comma-separated list of minimum umi family size to collapase on
    inputBinding:
      position: 101
      prefix: --Famsize
  - id: filter_threshold
    type:
      - 'null'
      - int
    doc: Minimum number of reads to pass alternative variants
    inputBinding:
      position: 101
      prefix: --FilterThreshold
  - id: ignore
    type:
      - 'null'
      - boolean
    doc: Keep the most abundant family and ignore families at other positions 
      within each group. Default is False, becomes True if used
    inputBinding:
      position: 101
      prefix: --Ignore
  - id: ignore_orphans
    type:
      - 'null'
      - boolean
    doc: Ignore orphans (paired reads that are not in a proper pair). Default is
      False, becomes True if used
    inputBinding:
      position: 101
      prefix: --IgnoreOrphans
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum read depth.
    default: 1000000
    inputBinding:
      position: 101
      prefix: --MaxDepth
  - id: memory
    type:
      - 'null'
      - string
    doc: Requested memory for submitting jobs to SGE.
    default: 20g
    inputBinding:
      position: 101
      prefix: --Memory
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Merge data, json and consensus files respectively into a 1 single file.
      Default is True, becomes False if used
    default: true
    inputBinding:
      position: 101
      prefix: --Merge
  - id: min_children
    type:
      - 'null'
      - int
    doc: Minimum children umi count. Values below are plotted in red
    inputBinding:
      position: 101
      prefix: --MinChildren
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage value. Values below are plotted in red
    inputBinding:
      position: 101
      prefix: --MinCov
  - id: min_ratio
    type:
      - 'null'
      - float
    doc: Minimum children to parent umi ratio. Values below are plotted in red
    inputBinding:
      position: 101
      prefix: --MinRatio
  - id: min_umis
    type:
      - 'null'
      - int
    doc: Minimum umi count. Values below are plotted in red
    inputBinding:
      position: 101
      prefix: --MinUmis
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory where subdirectories are created
    inputBinding:
      position: 101
      prefix: --Outdir
  - id: percent_threshold
    type:
      - 'null'
      - float
    doc: Base percent threshold in pileup column
    inputBinding:
      position: 101
      prefix: --PercentThreshold
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Generate figure plots. Default is True, becomes False if used
    default: true
    inputBinding:
      position: 101
      prefix: --Plot
  - id: position_threshold
    type:
      - 'null'
      - int
    doc: Umi position threshold for grouping umis together
    inputBinding:
      position: 101
      prefix: --Position
  - id: project
    type:
      - 'null'
      - string
    doc: Project for submitting jobs on Univa
    inputBinding:
      position: 101
      prefix: --Project
  - id: read_count
    type:
      - 'null'
      - int
    doc: Minimum number of reads in region required for grouping.
    default: 0
    inputBinding:
      position: 101
      prefix: --ReadCount
  - id: ref_threshold
    type:
      - 'null'
      - float
    doc: A position is considered variable of reference frequency is <= 
      ref_threshold
    inputBinding:
      position: 101
      prefix: --RefThreshold
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to the refeence genome
    inputBinding:
      position: 101
      prefix: --Reference
  - id: report
    type:
      - 'null'
      - boolean
    doc: Generate report. Default is True, becomes False if used
    default: true
    inputBinding:
      position: 101
      prefix: --Report
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name to appear to report. Optional, use Output directory 
      basename if not provided
    inputBinding:
      position: 101
      prefix: --Sample
  - id: separator
    type:
      - 'null'
      - string
    doc: String separating the UMI from the remaining of the read name
    inputBinding:
      position: 101
      prefix: --Separator
  - id: stepper
    type:
      - 'null'
      - string
    doc: 'Filter or include reads in the pileup. Options all: skip reads with BAM_FUNMAP,
      BAM_FSECONDARY, BAM_FQCFAIL, BAM_FDUP flags, nofilter: uses every single read
      turning off any filtering'
    inputBinding:
      position: 101
      prefix: --Stepper
  - id: truncate
    type:
      - 'null'
      - boolean
    doc: Only pileup columns in the exact region specificied are returned. 
      Default is False, becomes True is used
    inputBinding:
      position: 101
      prefix: --Truncate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
stdout: debarcer_run.out
