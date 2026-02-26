cwlVersion: v1.2
class: CommandLineTool
baseCommand: debarcer.py bed
label: debarcer_bed
doc: "Generate a BED file from a BAM file, identifying genomic intervals based on
  read depth.\n\nTool homepage: https://github.com/oicr-gsi/debarcer"
inputs:
  - id: bamfile
    type: File
    doc: Path to the BAM file
    inputBinding:
      position: 101
      prefix: --Bamfile
  - id: ignore_orphans
    type:
      - 'null'
      - boolean
    doc: Ignore orphans (paired reads that are not in a proper pair). Default is
      False, becomes True if used
    default: false
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
  - id: min_cov
    type: int
    doc: Minimum read depth value at all positions in genomic interval
    inputBinding:
      position: 101
      prefix: --MinCov
  - id: region_size
    type: int
    doc: Minimum length of the genomic interval (in bp)
    inputBinding:
      position: 101
      prefix: --RegionSize
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
outputs:
  - id: bedfile
    type: File
    doc: Path to the output bed file
    outputBinding:
      glob: $(inputs.bedfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
