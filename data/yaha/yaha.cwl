cwlVersion: v1.2
class: CommandLineTool
baseCommand: yaha
label: yaha
doc: "YAHA is a fast and sensitive DNA sequence aligner (align queries against a YAHA index).\n\nTool homepage: https://github.com/jannson/yaha"
inputs:
  - id: yaha_index_file
    type: File
    doc: YAHA index file (made by yaha_index); the .nib2 file of the same genome must be beside it
    secondaryFiles:
      - pattern: ^.nib2
        required: true
    inputBinding:
      position: 101
      prefix: -x
  - id: max_hits
    type:
      - 'null'
      - int
    doc: Maximum number of hits per query word (650)
    inputBinding:
      position: 101
      prefix: -H
  - id: output_modified_blast8
    type:
      - 'null'
      - string
    doc: Output file name; produces alignment output in modified Blast8 format
    inputBinding:
      position: 101
      prefix: -o8
  - id: output_sam_hard_clipping
    type:
      - 'null'
      - string
    doc: Output file name; produces alignment output in SAM format with hard clipping
    inputBinding:
      position: 101
      prefix: -osh
  - id: output_sam_soft_clipping
    type:
      - 'null'
      - string
    doc: Output file name; produces alignment output in SAM format with soft clipping
    inputBinding:
      position: 101
      prefix: -oss
  - id: affine_gap_scoring
    type:
      - 'null'
      - string
    doc: Controls use of Affine Gap Scoring (Y|N)
    inputBinding:
      position: 101
      prefix: -AGS
  - id: bandwidth
    type:
      - 'null'
      - int
    doc: Bandwidth
    inputBinding:
      position: 101
      prefix: -BW
  - id: breakpoint_penalty
    type:
      - 'null'
      - int
    doc: Breakpoint penalty
    inputBinding:
      position: 101
      prefix: -BP
  - id: gap_extension_cost
    type:
      - 'null'
      - int
    doc: Gap extension cost
    inputBinding:
      position: 101
      prefix: -GEC
  - id: gap_open_cost
    type:
      - 'null'
      - int
    doc: Gap open cost
    inputBinding:
      position: 101
      prefix: -GOC
  - id: include_secondary_alignments
    type:
      - 'null'
      - string
    doc: Controls inclusion of "secondary" alignments (Y|N)
    inputBinding:
      position: 101
      prefix: -FBS
  - id: match_score
    type:
      - 'null'
      - int
    doc: Match score
    inputBinding:
      position: 101
      prefix: -MS
  - id: max_desert
    type:
      - 'null'
      - int
    doc: Maximum desert length
    inputBinding:
      position: 101
      prefix: -MD
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum gap size
    inputBinding:
      position: 101
      prefix: -G
  - id: max_genomic_distance_penalty
    type:
      - 'null'
      - int
    doc: Maximum genomic distance penalty
    inputBinding:
      position: 101
      prefix: -MGDP
  - id: min_match
    type:
      - 'null'
      - int
    doc: Minimum match length
    inputBinding:
      position: 101
      prefix: -M
  - id: min_non_overlap
    type:
      - 'null'
      - string
    doc: Minimum non-overlap (defaults to minMatch)
    inputBinding:
      position: 101
      prefix: -MNO
  - id: min_percent_identity
    type:
      - 'null'
      - float
    doc: Minimum percent identity
    inputBinding:
      position: 101
      prefix: -P
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: optimal_query_coverage
    type:
      - 'null'
      - string
    doc: Controls use of the Optimal Query Coverage Algorithm (Y|N)
    inputBinding:
      position: 101
      prefix: -OQC
  - id: percent_reciprocal_length
    type:
      - 'null'
      - float
    doc: Percent reciprocal length for secondary alignments
    inputBinding:
      position: 101
      prefix: -PRL
  - id: percent_similar_score
    type:
      - 'null'
      - float
    doc: Percent similar score for secondary alignments
    inputBinding:
      position: 101
      prefix: -PSS
  - id: query_file
    type:
      - 'null'
      - File
    doc: Query file (FASTA or FASTQ) or stdin
    inputBinding:
      position: 101
      prefix: -q
  - id: replacement_cost
    type:
      - 'null'
      - int
    doc: Replacement cost
    inputBinding:
      position: 101
      prefix: -RC
  - id: xdropoff
    type:
      - 'null'
      - int
    doc: X-dropoff value
    inputBinding:
      position: 101
      prefix: -X
outputs:
  - id: blast8_output
    type:
      - 'null'
      - File
    doc: Alignments in modified Blast8 format
    outputBinding:
      glob: $(inputs.output_modified_blast8)
  - id: sam_hard_clipping_output
    type:
      - 'null'
      - File
    doc: Alignments in SAM format with hard clipping
    outputBinding:
      glob: $(inputs.output_sam_hard_clipping)
  - id: sam_soft_clipping_output
    type:
      - 'null'
      - File
    doc: Alignments in SAM format with soft clipping
    outputBinding:
      glob: $(inputs.output_sam_soft_clipping)
  - id: stdout
    type: stdout
    doc: Alignments written to standard output when no output file is given
stdout: yaha.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yaha:0.1.83--h1b792b2_3
