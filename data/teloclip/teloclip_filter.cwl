cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - teloclip
  - filter
label: teloclip_filter
doc: "Filter SAM file for clipped alignments containing unassembled telomeric\n  repeats.\n\
  \nTool homepage: https://github.com/Adamtaranto/teloclip"
inputs:
  - id: samfile
    type:
      - 'null'
      - File
    doc: SAM file to filter
    inputBinding:
      position: 1
  - id: fuzzy
    type:
      - 'null'
      - boolean
    doc: "If set, tolerate +/- 1 variation in motif\n                            \
      \      homopolymer runs i.e. TTAGGG ->\n                                  T{1,3}AG{2,4}.
      Default: Off"
    inputBinding:
      position: 102
      prefix: --fuzzy
  - id: keep_secondary
    type:
      - 'null'
      - boolean
    doc: "If set, include secondary alignments in\n                              \
      \    output. Default: Off (exclude secondary\n                             \
      \     alignments)."
    default: false
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
  - id: match_anywhere
    type:
      - 'null'
      - boolean
    doc: "If set, motif match may occur in unclipped\n                           \
      \       region of reads."
    inputBinding:
      position: 102
      prefix: --match-anywhere
  - id: max_break
    type:
      - 'null'
      - int
    doc: "Tolerate max N unaligned bases before contig\n                         \
      \         end."
    default: 50
    inputBinding:
      position: 102
      prefix: --max-break
  - id: min_anchor
    type:
      - 'null'
      - int
    doc: "Minimum number of aligned bases (anchor)\n                             \
      \     required on the non-clipped portion of the\n                         \
      \         read."
    default: 100
    inputBinding:
      position: 102
      prefix: --min-anchor
  - id: min_clip
    type:
      - 'null'
      - int
    doc: "Require clip to extend past ref contig end\n                           \
      \       by at least N bases."
    default: 1
    inputBinding:
      position: 102
      prefix: --min-clip
  - id: min_repeats
    type:
      - 'null'
      - int
    doc: "Minimum number of sequential pattern matches\n                         \
      \         required for a hit to be reported."
    default: 1
    inputBinding:
      position: 102
      prefix: --min-repeats
  - id: motifs
    type:
      - 'null'
      - string
    doc: "If set keep only reads containing given\n                              \
      \    motif/s from comma delimited list of\n                                \
      \  strings. By default also search for reverse\n                           \
      \       complement of motifs. i.e. TTAGGG,TTAAGGG\n                        \
      \          will also match CCCTAA,CCCTTAA"
    inputBinding:
      position: 102
      prefix: --motifs
  - id: no_rev
    type:
      - 'null'
      - boolean
    doc: "If set do NOT search for reverse complement\n                          \
      \        of specified motifs."
    inputBinding:
      position: 102
      prefix: --no-rev
  - id: ref_idx
    type: File
    doc: "Path to fai index for reference fasta. Index\n                         \
      \         fasta using `samtools faidx FASTA`"
    inputBinding:
      position: 102
      prefix: --ref-idx
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/teloclip:0.3.4--pyhdfd78af_0
stdout: teloclip_filter.out
