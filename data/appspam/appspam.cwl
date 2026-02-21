cwlVersion: v1.2
class: CommandLineTool
baseCommand: appspam
label: appspam
doc: "Alignment-free phylogenetic placement algorithm based on spaced word matches\n
  \nTool homepage: https://github.com/matthiasblanke/App-SpaM/"
inputs:
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Delimiter used for unassembled references.
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: dont_care
    type:
      - 'null'
      - int
    doc: Number of don't care positions.
    inputBinding:
      position: 101
      prefix: --dontCare
  - id: mode
    type:
      - 'null'
      - string
    doc: Placement-mode. One of [MINDIST, SPAMCOUNT, LCADIST, LCACOUNT, SPAMX]
    inputBinding:
      position: 101
      prefix: --mode
  - id: pattern
    type:
      - 'null'
      - int
    doc: Number of patterns.
    inputBinding:
      position: 101
      prefix: --pattern
  - id: queries
    type: File
    doc: Full path to fasta file with query sequences.
    inputBinding:
      position: 101
      prefix: -q
  - id: read_block_size
    type:
      - 'null'
      - int
    doc: Read block size.
    inputBinding:
      position: 101
      prefix: --readBlockSize
  - id: references
    type: File
    doc: Full path to fasta file with references.
    inputBinding:
      position: 101
      prefix: -s
  - id: sampling
    type:
      - 'null'
      - boolean
    doc: 'Experimental: Samples the spaced word matches.'
    inputBinding:
      position: 101
      prefix: --sampling
  - id: spamx
    type:
      - 'null'
      - float
    doc: Threshold when to place at leaves for SPAMX.
    inputBinding:
      position: 101
      prefix: --spamx
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold used for filtering spaced word matches.
    inputBinding:
      position: 101
      prefix: --threshold
  - id: tree
    type: File
    doc: File of reference tree in newick format (Rooted, bifurcating tree).
    inputBinding:
      position: 101
      prefix: -t
  - id: unassembled
    type:
      - 'null'
      - boolean
    doc: Use unassembled references.
    inputBinding:
      position: 101
      prefix: --unassembled
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose mode with additional information printed to std_out.
    inputBinding:
      position: 101
      prefix: -v
  - id: weight
    type:
      - 'null'
      - int
    doc: Weight of pattern.
    inputBinding:
      position: 101
      prefix: --weight
  - id: write_histogram
    type:
      - 'null'
      - boolean
    doc: Write scores for all spaced word matches to file.
    inputBinding:
      position: 101
      prefix: --write-histogram
  - id: write_scores
    type:
      - 'null'
      - boolean
    doc: Write all query-reference distances to files.
    inputBinding:
      position: 101
      prefix: --write-scores
outputs:
  - id: out_jplace
    type:
      - 'null'
      - File
    doc: Path and name to JPlace output file.
    outputBinding:
      glob: $(inputs.out_jplace)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/appspam:1.03--h9f5acd7_3
