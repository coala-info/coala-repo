cwlVersion: v1.2
class: CommandLineTool
baseCommand: msamtools_filter
label: msamtools_filter
doc: "Filter alignments from BAM/SAM files.\n\nTool homepage: https://github.com/arumugamlab/msamtools"
inputs:
  - id: bamfile
    type: File
    doc: input SAM/BAM file
    inputBinding:
      position: 1
  - id: include_header
    type:
      - 'null'
      - boolean
    doc: print header for the SAM output
    default: false
    inputBinding:
      position: 102
      prefix: -h
  - id: input_is_sam
    type:
      - 'null'
      - boolean
    doc: input is SAM
    default: false
    inputBinding:
      position: 102
      prefix: -S
  - id: invert_filter
    type:
      - 'null'
      - boolean
    doc: invert the effect of the filter
    default: false
    inputBinding:
      position: 102
      prefix: --invert
  - id: keep_best_hit
    type:
      - 'null'
      - boolean
    doc: keep all highest scoring hit(s) per read
    default: false
    inputBinding:
      position: 102
      prefix: --besthit
  - id: keep_unique_best_hit
    type:
      - 'null'
      - boolean
    doc: keep only one highest scoring hit per read, only if it is unique
    default: false
    inputBinding:
      position: 102
      prefix: --uniqhit
  - id: keep_unmapped
    type:
      - 'null'
      - boolean
    doc: report unmapped reads, when filtering using upper-limit thresholds
    default: false
    inputBinding:
      position: 102
      prefix: --keep_unmapped
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: min. length of alignment
    default: 0
    inputBinding:
      position: 102
      prefix: -l
  - id: min_query_aligned_percent
    type:
      - 'null'
      - int
    doc: min. percent of the query that must be aligned, between 0 and 100
    default: 0
    inputBinding:
      position: 102
      prefix: -z
  - id: min_sequence_identity_percent
    type:
      - 'null'
      - int
    doc: min. sequence identity of alignment, in percentage, integer between 0 
      and 100; requires NM field to be present
    default: 0
    inputBinding:
      position: 102
      prefix: -p
  - id: output_bam
    type:
      - 'null'
      - boolean
    doc: output BAM
    default: false
    inputBinding:
      position: 102
      prefix: -b
  - id: rescore_alignments
    type:
      - 'null'
      - boolean
    doc: rescore alignments using MD or NM fields, in that order
    default: false
    inputBinding:
      position: 102
      prefix: --rescore
  - id: sequence_identity_parts_per_thousand
    type:
      - 'null'
      - int
    doc: min/max sequence identity of alignment, in parts per thousand, integer 
      between -1000 and 1000; requires NM field to be present. +ve values mean 
      minimum ppt and -ve values mean maximum ppt.
    default: 0
    inputBinding:
      position: 102
      prefix: --ppt
  - id: uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: uncompressed BAM output (force -b)
    default: false
    inputBinding:
      position: 102
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msamtools:1.1.3--h577a1d6_1
stdout: msamtools_filter.out
