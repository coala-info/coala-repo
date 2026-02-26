cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - teloclip
  - extract
label: teloclip_extract
doc: "Extract overhanging reads for each end of each reference contig. Reads are always
  written to output files.\n\nTool homepage: https://github.com/Adamtaranto/teloclip"
inputs:
  - id: samfile
    type:
      - 'null'
      - File
    doc: Input SAM file
    inputBinding:
      position: 1
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: 'Number of sequences to buffer before writing (default: 1000).'
    default: 1000
    inputBinding:
      position: 102
      prefix: --buffer-size
  - id: count_motifs
    type:
      - 'null'
      - string
    doc: Comma-delimited motif sequences to count in overhang regions (e.g., 
      "TTAGGG,CCCTAA").
    inputBinding:
      position: 102
      prefix: --count-motifs
  - id: extract_dir
    type:
      - 'null'
      - Directory
    doc: 'Write extracted reads to this directory. Default: cwd.'
    default: cwd
    inputBinding:
      position: 102
      prefix: --extract-dir
  - id: fuzzy_count
    type:
      - 'null'
      - boolean
    doc: Use fuzzy motif matching allowing ±1 character variation when counting 
      motifs.
    inputBinding:
      position: 102
      prefix: --fuzzy-count
  - id: include_stats
    type:
      - 'null'
      - boolean
    doc: Include mapping quality, clip length, and motif counts in FASTA 
      headers.
    inputBinding:
      position: 102
      prefix: --include-stats
  - id: keep_secondary
    type:
      - 'null'
      - boolean
    doc: 'If set, include secondary alignments in output. Default: Off (exclude secondary
      alignments).'
    inputBinding:
      position: 102
      prefix: --keep-secondary
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Logging level (default: INFO).'
    default: INFO
    inputBinding:
      position: 102
      prefix: --log-level
  - id: max_break
    type:
      - 'null'
      - int
    doc: 'Tolerate max N unaligned bases before contig end. Default: 50'
    default: 50
    inputBinding:
      position: 102
      prefix: --max-break
  - id: min_anchor
    type:
      - 'null'
      - int
    doc: 'Minimum anchored alignment length required (default: 100).'
    default: 100
    inputBinding:
      position: 102
      prefix: --min-anchor
  - id: min_clip
    type:
      - 'null'
      - int
    doc: 'Require clip to extend past ref contig end by at least N bases. Default:
      1'
    default: 1
    inputBinding:
      position: 102
      prefix: --min-clip
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: 'Minimum mapping quality required (default: 0).'
    default: 0
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: no_mask_overhangs
    type:
      - 'null'
      - boolean
    doc: Do not convert overhang sequences to lowercase.
    inputBinding:
      position: 102
      prefix: --no-mask-overhangs
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format for extracted sequences (default: fasta).'
    default: fasta
    inputBinding:
      position: 102
      prefix: --output-format
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Use this prefix for output files. Default: None.'
    inputBinding:
      position: 102
      prefix: --prefix
  - id: ref_idx
    type: File
    doc: Path to fai index for reference fasta. Index fasta using `samtools 
      faidx FASTA`
    inputBinding:
      position: 102
      prefix: --ref-idx
  - id: report_stats
    type:
      - 'null'
      - boolean
    doc: Write extraction statistics to file in output directory.
    inputBinding:
      position: 102
      prefix: --report-stats
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/teloclip:0.3.4--pyhdfd78af_0
stdout: teloclip_extract.out
