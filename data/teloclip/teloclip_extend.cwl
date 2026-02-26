cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - teloclip
  - extend
label: teloclip_extend
doc: "Extend contigs using overhang analysis from soft-clipped alignments.\n\nTool
  homepage: https://github.com/Adamtaranto/teloclip"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: reference_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 2
  - id: count_motifs
    type:
      - 'null'
      - string
    doc: Comma-delimited motif sequences to count in overhang regions (e.g., 
      "TTAGGG,CCCTAA")
    inputBinding:
      position: 103
      prefix: --count-motifs
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Report extensions without modifying sequences
    inputBinding:
      position: 103
      prefix: --dry-run
  - id: exclude_contigs
    type:
      - 'null'
      - string
    doc: Comma-delimited list of contig names to exclude from extension (e.g., 
      "chrM,chrC,scaffold_123")
    inputBinding:
      position: 103
      prefix: --exclude-contigs
  - id: exclude_contigs_file
    type:
      - 'null'
      - File
    doc: Text file containing contig names to exclude (one per line)
    inputBinding:
      position: 103
      prefix: --exclude-contigs-file
  - id: exclude_outliers
    type:
      - 'null'
      - boolean
    doc: Exclude outlier contigs from extension
    inputBinding:
      position: 103
      prefix: --exclude-outliers
  - id: fuzzy_count
    type:
      - 'null'
      - boolean
    doc: Use fuzzy motif matching allowing ±1 character variation when counting 
      motifs
    inputBinding:
      position: 103
      prefix: --fuzzy-count
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level
    default: INFO
    inputBinding:
      position: 103
      prefix: --log-level
  - id: max_break
    type:
      - 'null'
      - int
    doc: Maximum gap allowed between alignment and contig end
    default: 10
    inputBinding:
      position: 103
      prefix: --max-break
  - id: max_homopolymer
    type:
      - 'null'
      - int
    doc: Maximum homopolymer run length allowed
    default: 500
    inputBinding:
      position: 103
      prefix: --max-homopolymer
  - id: min_anchor
    type:
      - 'null'
      - int
    doc: Minimum anchor length required for alignment
    default: 100
    inputBinding:
      position: 103
      prefix: --min-anchor
  - id: min_extension
    type:
      - 'null'
      - int
    doc: Minimum overhang length for extension
    default: 1
    inputBinding:
      position: 103
      prefix: --min-extension
  - id: min_overhangs
    type:
      - 'null'
      - int
    doc: Minimum supporting overhangs required
    default: 1
    inputBinding:
      position: 103
      prefix: --min-overhangs
  - id: outlier_threshold
    type:
      - 'null'
      - float
    doc: Z-score threshold for outlier detection
    default: 2.0
    inputBinding:
      position: 103
      prefix: --outlier-threshold
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for default output filenames
    default: teloclip_extended
    inputBinding:
      position: 103
      prefix: --prefix
  - id: screen_terminal_bases
    type:
      - 'null'
      - int
    doc: 'Number of terminal bases to screen for motifs in original contigs (default:
      0, disabled)'
    default: 0
    inputBinding:
      position: 103
      prefix: --screen-terminal-bases
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: Extended FASTA output file
    outputBinding:
      glob: $(inputs.output_fasta)
  - id: stats_report
    type:
      - 'null'
      - File
    doc: Statistics report output file
    outputBinding:
      glob: $(inputs.stats_report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/teloclip:0.3.4--pyhdfd78af_0
