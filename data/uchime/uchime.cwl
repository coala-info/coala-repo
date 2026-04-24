cwlVersion: v1.2
class: CommandLineTool
baseCommand: uchime
label: uchime
doc: "UCHIME is an algorithm for detecting chimeric sequences, usable in de novo or
  reference database mode.\n\nTool homepage: https://drive5.com/uchime/uchime_download.html"
inputs:
  - id: abskew
    type:
      - 'null'
      - float
    doc: Minimum abundance skew. De novo mode only.
    inputBinding:
      position: 101
      prefix: --abskew
  - id: chunks
    type:
      - 'null'
      - int
    doc: Number of chunks to extract from the query sequence when searching for parents.
    inputBinding:
      position: 101
      prefix: --chunks
  - id: db
    type:
      - 'null'
      - File
    doc: Reference database in FASTA format. If not specified, uchime uses de novo
      mode.
    inputBinding:
      position: 101
      prefix: --db
  - id: dn
    type:
      - 'null'
      - float
    doc: Pseudo-count prior on number of no votes.
    inputBinding:
      position: 101
      prefix: --dn
  - id: idsmoothwindow
    type:
      - 'null'
      - int
    doc: Length of id smoothing window.
    inputBinding:
      position: 101
      prefix: --idsmoothwindow
  - id: input
    type: File
    doc: Query sequences in FASTA format.
    inputBinding:
      position: 101
      prefix: --input
  - id: maxlen
    type:
      - 'null'
      - int
    doc: Maximum sequence length.
    inputBinding:
      position: 101
      prefix: --maxlen
  - id: maxp
    type:
      - 'null'
      - int
    doc: Maximum number of candidate parents to consider.
    inputBinding:
      position: 101
      prefix: --maxp
  - id: minchunk
    type:
      - 'null'
      - int
    doc: Minimum length of a chunk.
    inputBinding:
      position: 101
      prefix: --minchunk
  - id: mindiv
    type:
      - 'null'
      - float
    doc: Minimum divergence ratio.
    inputBinding:
      position: 101
      prefix: --mindiv
  - id: minh
    type:
      - 'null'
      - float
    doc: Mininum score to report chimera.
    inputBinding:
      position: 101
      prefix: --minh
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum sequence length.
    inputBinding:
      position: 101
      prefix: --minlen
  - id: minsmoothid
    type:
      - 'null'
      - float
    doc: Minimum factional identity over smoothed window of candidate parent.
    inputBinding:
      position: 101
      prefix: --minsmoothid
  - id: no_ovchunks
    type:
      - 'null'
      - boolean
    doc: Do not use overlapping chunks (default).
    inputBinding:
      position: 101
      prefix: --noovchunks
  - id: ovchunks
    type:
      - 'null'
      - boolean
    doc: Use overlapping chunks.
    inputBinding:
      position: 101
      prefix: --ovchunks
  - id: queryfract
    type:
      - 'null'
      - float
    doc: Minimum fraction of the query sequence that must be covered by a local-X
      alignment.
    inputBinding:
      position: 101
      prefix: --queryfract
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not display progress messages on stderr.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: self
    type:
      - 'null'
      - boolean
    doc: In reference database mode, exclude a reference sequence if it has the same
      label as the query.
    inputBinding:
      position: 101
      prefix: --self
  - id: skipgaps
    type:
      - 'null'
      - boolean
    doc: Columns containing gaps do not count as diffs.
    inputBinding:
      position: 101
      prefix: --skipgaps
  - id: skipgaps2
    type:
      - 'null'
      - boolean
    doc: Columns immediately adjacent to a gap are not counted as diffs.
    inputBinding:
      position: 101
      prefix: --skipgaps2
  - id: ucl
    type:
      - 'null'
      - boolean
    doc: Use local-X alignments (default is global-X).
    inputBinding:
      position: 101
      prefix: --ucl
  - id: xa
    type:
      - 'null'
      - float
    doc: Weight of an abstain vote.
    inputBinding:
      position: 101
      prefix: --xa
  - id: xn
    type:
      - 'null'
      - float
    doc: Weight of a no vote (beta parameter).
    inputBinding:
      position: 101
      prefix: --xn
outputs:
  - id: uchimeout
    type:
      - 'null'
      - File
    doc: Output in tabbed format with one record per query sequence.
    outputBinding:
      glob: $(inputs.uchimeout)
  - id: uchimealns
    type:
      - 'null'
      - File
    doc: Multiple alignments of query sequences to parents in human-readable format.
    outputBinding:
      glob: $(inputs.uchimealns)
  - id: log
    type:
      - 'null'
      - File
    doc: Write miscellaneous information to the log file.
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uchime:4.2--h9948957_0
