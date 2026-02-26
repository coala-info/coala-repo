cwlVersion: v1.2
class: CommandLineTool
baseCommand: msamtools_summary
label: msamtools_summary
doc: "Prints summary of alignments in the given BAM/SAM file. By default, it prints
  a summary line per alignment entry in the file. The summary is a tab-delimited line
  with the following fields: qname,aligned_qlen,target_name,glocal_align_len,matches,percent_identity
  glocal_align_len includes the unaligned qlen mimicing a global alignment in the
  query and local alignment in target, thus glocal. With --stats option, summary is
  consolidated as distribution of read counts for a given measure. --stats=mapped\
  \   - distribution for number of mapped query bases --stats=unmapped - distribution
  for number of unmapped query bases --stats=edit     - distribution for edit distances
  --stats=score    - distribution for score=match-edit\n\nTool homepage: https://github.com/arumugamlab/msamtools"
inputs:
  - id: input_bamfile
    type: File
    doc: input SAM/BAM file
    inputBinding:
      position: 1
  - id: count_unique_inserts
    type:
      - 'null'
      - boolean
    doc: count number of unique inserts in BAM file
    default: false
    inputBinding:
      position: 102
      prefix: --count
  - id: edge_bases
    type:
      - 'null'
      - int
    doc: ignore alignment if reads map to <num> bases at the edge of target 
      sequence
    default: 0
    inputBinding:
      position: 102
      prefix: --edge
  - id: input_is_sam
    type:
      - 'null'
      - boolean
    doc: input is SAM
    default: false
    inputBinding:
      position: 102
      prefix: -S
  - id: stats
    type:
      - 'null'
      - string
    doc: '{mapped|unmapped|edit|score} only report readcount distribution for specified
      stats, not read-level stats'
    default: none
    inputBinding:
      position: 102
      prefix: --stats
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msamtools:1.1.3--h577a1d6_1
stdout: msamtools_summary.out
