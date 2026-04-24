cwlVersion: v1.2
class: CommandLineTool
baseCommand: naibr
label: naibr-plus_naibr
doc: "NAIBR identifies novel adjacencies created by structural variation events such
  as deletions, duplications, inversions, and complex rearrangements using linked-read
  whole-genome sequencing data as produced by 10X Genomics. Please refer to the publication
  for details about the method.\n\nTool homepage: https://github.com/pontushojer/NAIBR"
inputs:
  - id: input_config
    type: File
    doc: Path to config file with "=" separated parameters and values.
    inputBinding:
      position: 1
  - id: bam_file
    type: File
    doc: Path to BAM file with phased linked reads, i.e. has BX and HP tags.
    inputBinding:
      position: 102
  - id: blacklist
    type:
      - 'null'
      - File
    doc: Path to BED file with regions to ignore
    inputBinding:
      position: 102
  - id: candidates
    type:
      - 'null'
      - File
    doc: Path to BEDPE with candidiate SVs to evaluate
    inputBinding:
      position: 102
  - id: d
    type:
      - 'null'
      - int
    doc: Maximum distance between read-pairs in a linked-read.
    inputBinding:
      position: 102
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Run in debug mode.
    inputBinding:
      position: 102
  - id: k
    type:
      - 'null'
      - int
    doc: Minimum number of barcode overlaps supporting a candidate NA.
    inputBinding:
      position: 102
  - id: max_len
    type:
      - 'null'
      - int
    doc: TO_BE_ADDED.
    inputBinding:
      position: 102
  - id: min_discs
    type:
      - 'null'
      - int
    doc: Minimum number of discordant reads.
    inputBinding:
      position: 102
  - id: min_len
    type:
      - 'null'
      - string
    doc: 'Minimum length of linked read fragment. Default: 2*LMAX'
    inputBinding:
      position: 102
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to evaluate reads.
    inputBinding:
      position: 102
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum reads in linked read fragment.
    inputBinding:
      position: 102
  - id: min_sv
    type:
      - 'null'
      - int
    doc: Minimum size of structural variant.
    inputBinding:
      position: 102
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Path to output directory.
    inputBinding:
      position: 102
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 102
  - id: sd_mult
    type:
      - 'null'
      - int
    doc: Stddev multiplier for max/min insert size (LMAX/LMIN) calculcation.
    inputBinding:
      position: 102
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads to use.
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/naibr-plus:0.5.3--pyhdfd78af_0
stdout: naibr-plus_naibr.out
