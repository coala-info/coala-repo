cwlVersion: v1.2
class: CommandLineTool
baseCommand: htseq-clip extract
label: htseq-clip_extract
doc: "extracts crosslink sites, insertions or deletions\n\nTool homepage: https://github.com/EMBL-Hentze-group/htseq-clip"
inputs:
  - id: chromosomes_list
    type:
      - 'null'
      - File
    doc: 'Extract crosslink sites only from chromosomes given in this file (one chromosome
      per line, default: None)'
    inputBinding:
      position: 101
      prefix: --chrom
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of cores to use for alignment parsing
    default: 5
    inputBinding:
      position: 101
      prefix: --cores
  - id: ignore
    type:
      - 'null'
      - boolean
    doc: flag to ignore crosslink sites outside of genome
    inputBinding:
      position: 101
      prefix: --ignore
  - id: ignore_pcr_duplicates
    type:
      - 'null'
      - boolean
    doc: flag to ignore PCR duplicates (only if bam file has PCR duplicate flag 
      in alignment)
    inputBinding:
      position: 101
      prefix: --ignore_PCR_duplicates
  - id: input_file
    type: File
    doc: input file (.bam, MUST be co-ordinate sorted and indexed)
    inputBinding:
      position: 101
      prefix: --input
  - id: mate
    type: int
    doc: 'for paired end sequencing, select the read/mate to extract the crosslink
      sites from. Must be one of: 1, 2'
    inputBinding:
      position: 101
      prefix: --mate
  - id: max_read_interval
    type:
      - 'null'
      - int
    doc: maximum read interval length
    default: 10000
    inputBinding:
      position: 101
      prefix: --maxReadInterval
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: maximum read length
    default: 500
    inputBinding:
      position: 101
      prefix: --maxReadLength
  - id: min_alignment_quality
    type:
      - 'null'
      - int
    doc: minimum alignment quality
    default: 10
    inputBinding:
      position: 101
      prefix: --minAlignmentQuality
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: minimum read length
    default: 0
    inputBinding:
      position: 101
      prefix: --minReadLength
  - id: offset_length
    type:
      - 'null'
      - int
    doc: Number of nucleotides to offset for crosslink sites
    default: 0
    inputBinding:
      position: 101
      prefix: --offset
  - id: primary
    type:
      - 'null'
      - boolean
    doc: flag to use only primary positions of multimapping reads
    inputBinding:
      position: 101
      prefix: --primary
  - id: site
    type:
      - 'null'
      - string
    doc: 'Crosslink site choices, must be one of: s, i, d, m, e s: start site i: insertion
      site d: deletion site m: middle site e: end site'
    default: e
    inputBinding:
      position: 101
      prefix: --site
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: 'Path to create and store temp files (default behavior: use folder from "--output"
      parameter)'
    inputBinding:
      position: 101
      prefix: --tmp
  - id: verbose_level
    type:
      - 'null'
      - string
    doc: 'Verbose level. Allowed choices: debug, info, warn, quiet'
    default: info
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'output file (.bed, default: print to console)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htseq-clip:2.19.0b0--pyh086e186_0
