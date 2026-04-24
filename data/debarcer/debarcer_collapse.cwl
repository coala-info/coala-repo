cwlVersion: v1.2
class: CommandLineTool
baseCommand: debarcer.py collapse
label: debarcer_collapse
doc: "Collapse UMIs based on various criteria.\n\nTool homepage: https://github.com/oicr-gsi/debarcer"
inputs:
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
    inputBinding:
      position: 101
      prefix: --Quality
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
  - id: famsize
    type:
      - 'null'
      - string
    doc: Comma-separated list of minimum umi family size to collapase on
    inputBinding:
      position: 101
      prefix: --Famsize
  - id: ignore_orphans
    type:
      - 'null'
      - boolean
    doc: Ignore orphans (paired reads that are not in a proper pair).
    inputBinding:
      position: 101
      prefix: --IgnoreOrphans
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum read depth.
    inputBinding:
      position: 101
      prefix: --MaxDepth
  - id: percent_threshold
    type:
      - 'null'
      - float
    doc: Majority rule consensus threshold in pileup column
    inputBinding:
      position: 101
      prefix: --PercentThreshold
  - id: position
    type:
      - 'null'
      - int
    doc: Umi position threshold for grouping umis together
    inputBinding:
      position: 101
      prefix: --Position
  - id: reference
    type: File
    doc: Path to the refeence genome
    inputBinding:
      position: 101
      prefix: --Reference
  - id: region
    type: string
    doc: Region coordinates to search for UMIs. chrN:posA-posB. posA and posB 
      are 1-based included
    inputBinding:
      position: 101
      prefix: --Region
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
    doc: If truncate is True and a region is given, only pileup columns in the 
      exact region specificied are returned.
    inputBinding:
      position: 101
      prefix: --Truncate
  - id: umifile
    type: File
    doc: Path to the .umis file
    inputBinding:
      position: 101
      prefix: --Umi
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory where subdirectories are created
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
