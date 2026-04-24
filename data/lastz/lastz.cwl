cwlVersion: v1.2
class: CommandLineTool
baseCommand: lastz
label: lastz
doc: "Search for PATTERN in each FILE.\n\nTool homepage: http://www.bx.psu.edu/~rsharris/lastz/"
inputs:
  - id: target
    type: string
    doc: spec/file containing target sequence (fasta, fastq, nib, 2bit or hsx); 
      [start..end] defines a subrange of the file
    inputBinding:
      position: 1
  - id: query
    type:
      - 'null'
      - string
    doc: spec/file containing query sequences; if absent, queries come from 
      stdin (if needed)
    inputBinding:
      position: 2
  - id: allocate_traceback
    type:
      - 'null'
      - string
    doc: space for trace-back information
    inputBinding:
      position: 103
      prefix: --allocate:traceback
  - id: ambiguous
    type:
      - 'null'
      - string
    doc: treat N as an ambiguous nucleotide
    inputBinding:
      position: 103
      prefix: --ambiguous
  - id: chain
    type:
      - 'null'
      - boolean
    doc: perform chaining (by default no chaining is performed)
    inputBinding:
      position: 103
      prefix: --chain
  - id: chain_penalties
    type:
      - 'null'
      - string
    doc: perform chaining with given penalties for diagonal and anti-diagonal
    inputBinding:
      position: 103
      prefix: --chain
  - id: coverage
    type:
      - 'null'
      - string
    doc: filter alignments by percentage of query covered 0<=min<=max<=100; 
      blocks (or HSPs) outside min..max are discarded (default is no query 
      coverage filtering)
    inputBinding:
      position: 103
      prefix: --coverage
  - id: entropy
    type:
      - 'null'
      - boolean
    doc: involve entropy in filtering high scoring pairs (default is "entropy")
    inputBinding:
      position: 103
      prefix: --entropy
  - id: exact
    type:
      - 'null'
      - int
    doc: set threshold for exact matches if specified, exact matches are found 
      rather than high scoring pairs (replaces --hspthresh)
    inputBinding:
      position: 103
      prefix: --exact
  - id: format
    type:
      - 'null'
      - string
    doc: specify output format; one of lav, axt, maf, cigar, rdotplot, text or 
      general
    inputBinding:
      position: 103
      prefix: --format
  - id: gap
    type:
      - 'null'
      - string
    doc: set gap open and extend penalties
    inputBinding:
      position: 103
      prefix: --gap
  - id: gapped
    type:
      - 'null'
      - boolean
    doc: perform gapped alignment (instead of gap-free) (by default gapped 
      alignment is performed)
    inputBinding:
      position: 103
      prefix: --gapped
  - id: gappedthresh
    type:
      - 'null'
      - string
    doc: set threshold for gapped alignments gapped extensions scoring lower are
      discarded <score> can also be a percentage or base count (default is to 
      use same value as --hspthresh)
    inputBinding:
      position: 103
      prefix: --gappedthresh
  - id: gfextend
    type:
      - 'null'
      - boolean
    doc: perform gap-free extension of seed hits to HSPs (by default extension 
      is performed)
    inputBinding:
      position: 103
      prefix: --gfextend
  - id: hspthresh
    type:
      - 'null'
      - string
    doc: set threshold for high scoring pairs (default is 3000) ungapped 
      extensions scoring lower are discarded <score> can also be a percentage or
      base count
    inputBinding:
      position: 103
      prefix: --hspthresh
  - id: identity
    type:
      - 'null'
      - string
    doc: filter alignments by percent identity 0<=min<=max<=100; blocks (or 
      HSPs) outside min..max are discarded (default is no identity filtering)
    inputBinding:
      position: 103
      prefix: --identity
  - id: inner
    type:
      - 'null'
      - string
    doc: set threshold for HSPs during interpolation (default is no 
      interpolation)
    inputBinding:
      position: 103
      prefix: --inner
  - id: masking
    type:
      - 'null'
      - int
    doc: mask any position in target hit this many times zero indicates no 
      masking (default is no masking)
    inputBinding:
      position: 103
      prefix: --masking
  - id: match
    type:
      - 'null'
      - string
    doc: scores are +R/-P for match/mismatch
    inputBinding:
      position: 103
      prefix: --match
  - id: no_entropy
    type:
      - 'null'
      - boolean
    doc: involve entropy in filtering high scoring pairs (default is "entropy")
    inputBinding:
      position: 103
      prefix: --no-entropy
  - id: no_gapped
    type:
      - 'null'
      - boolean
    doc: perform gapped alignment (instead of gap-free) (by default gapped 
      alignment is performed)
    inputBinding:
      position: 103
      prefix: --no-gapped
  - id: no_gfextend
    type:
      - 'null'
      - boolean
    doc: perform gap-free extension of seed hits to HSPs (by default extension 
      is performed)
    inputBinding:
      position: 103
      prefix: --no-gfextend
  - id: no_transition
    type:
      - 'null'
      - boolean
    doc: allow one or two transitions in a seed hit (by default a transition is 
      allowed)
    inputBinding:
      position: 103
      prefix: --no-transition
  - id: nomirror
    type:
      - 'null'
      - boolean
    doc: don't report mirror-image alignments when using --self (default is to 
      skip processing them, but recreate them in the output)
    inputBinding:
      position: 103
      prefix: --nomirror
  - id: notrivial
    type:
      - 'null'
      - boolean
    doc: do not output a trivial self-alignment block if the target and query 
      happen to be identical
    inputBinding:
      position: 103
      prefix: --notrivial
  - id: noxtrim
    type:
      - 'null'
      - boolean
    doc: if x-drop extension encounters end of sequence, don't trim back to peak
      score (use this for short reads)
    inputBinding:
      position: 103
      prefix: --noxtrim
  - id: noytrim
    type:
      - 'null'
      - boolean
    doc: if y-drop extension encounters end of sequence, don't trim back to peak
      score (use this for short reads)
    inputBinding:
      position: 103
      prefix: --noytrim
  - id: progress
    type:
      - 'null'
      - int
    doc: report processing of every nth query
    inputBinding:
      position: 103
      prefix: --progress
  - id: scores
    type:
      - 'null'
      - File
    doc: read substitution scores from a file
    inputBinding:
      position: 103
      prefix: --scores
  - id: seed
    type:
      - 'null'
      - string
    doc: use a word with no gaps instead of a seed pattern
    inputBinding:
      position: 103
      prefix: --seed
  - id: self
    type:
      - 'null'
      - boolean
    doc: the target sequence is also the query (this replaces the query file)
    inputBinding:
      position: 103
      prefix: --self
  - id: step
    type:
      - 'null'
      - int
    doc: set step length
    inputBinding:
      position: 103
      prefix: --step
  - id: strand
    type:
      - 'null'
      - string
    doc: search both strands
    inputBinding:
      position: 103
      prefix: --strand
  - id: transition
    type:
      - 'null'
      - string
    doc: allow one or two transitions in a seed hit (by default a transition is 
      allowed)
    inputBinding:
      position: 103
      prefix: --transition
  - id: xdrop
    type:
      - 'null'
      - string
    doc: set x-drop threshold
    inputBinding:
      position: 103
      prefix: --xdrop
  - id: ydrop
    type:
      - 'null'
      - string
    doc: set y-drop threshold
    inputBinding:
      position: 103
      prefix: --ydrop
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: specify output alignment file; otherwise alignments are written to 
      stdout
    outputBinding:
      glob: $(inputs.output)
  - id: rdotplot
    type:
      - 'null'
      - File
    doc: create an output file suitable for plotting in R.
    outputBinding:
      glob: $(inputs.rdotplot)
  - id: axt
    type:
      - 'null'
      - File
    doc: create an output file in AXT format.
    outputBinding:
      glob: $(inputs.axt)
  - id: maf
    type:
      - 'null'
      - File
    doc: create an output file in MAF format.
    outputBinding:
      glob: $(inputs.maf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lastz:1.04.52--h7b50bb2_1
