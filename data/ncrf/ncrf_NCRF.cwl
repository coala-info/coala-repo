cwlVersion: v1.2
class: CommandLineTool
baseCommand: NCRF
label: ncrf_NCRF
doc: "Noise Cancelling Repeat Finder, to find tandem repeats in noisy reads. The
  fasta file is read from standard input.\n\nTool homepage: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder"
inputs:
  - id: fasta_file
    type: File
    doc: fasta file containing sequences; read from stdin
  - id: motifs
    type:
      type: array
      items: string
    doc: dna repeat motif to search for, as [<name>:]<motif> (there can be more than one motif)
    inputBinding:
      position: 1
  - id: minmratio
    type:
      - 'null'
      - string
    doc: discard alignments with a low frequency of matches; ratio between 0 and 1 (e.g. 0.85) or a percentage (e.g. 85%)
    inputBinding:
      position: 10
      prefix: --minmratio=
      separate: false
  - id: maxnoise
    type:
      - 'null'
      - string
    doc: same as --minmratio but with 1-ratio
    inputBinding:
      position: 10
      prefix: --maxnoise=
      separate: false
  - id: minlength
    type:
      - 'null'
      - int
    doc: discard alignments that do not have a long enough repeat (default 500)
    inputBinding:
      position: 10
      prefix: --minlength=
      separate: false
  - id: minscore
    type:
      - 'null'
      - int
    doc: discard alignments that do not score high enough (default zero)
    inputBinding:
      position: 10
      prefix: --minscore=
      separate: false
  - id: stats
    type:
      - 'null'
      - string
    doc: show match/mismatch/insert/delete counts (use 'events')
    inputBinding:
      position: 10
      prefix: --stats=
      separate: false
  - id: scoring
    type:
      - 'null'
      - string
    doc: "scoring scheme: pacbio, nanopore or simple:<M>/<E>"
    inputBinding:
      position: 10
      prefix: --scoring=
      separate: false
  - id: match
    type:
      - 'null'
      - int
    doc: (M) reward when sequence matches motif
    inputBinding:
      position: 10
      prefix: --match=
      separate: false
  - id: mismatch
    type:
      - 'null'
      - int
    doc: (MM) penalty when sequence mismatches motif
    inputBinding:
      position: 10
      prefix: --mismatch=
      separate: false
  - id: iopen
    type:
      - 'null'
      - int
    doc: (IO) first penalty when sequence has a nucleotide the motif does not
    inputBinding:
      position: 10
      prefix: --iopen=
      separate: false
  - id: iextend
    type:
      - 'null'
      - int
    doc: (IX) other penalty when sequence has a nucleotide the motif does not
    inputBinding:
      position: 10
      prefix: --iextend=
      separate: false
  - id: dopen
    type:
      - 'null'
      - int
    doc: (DO) first penalty when motif has a nucleotide the sequence does not
    inputBinding:
      position: 10
      prefix: --dopen=
      separate: false
  - id: dextend
    type:
      - 'null'
      - int
    doc: (DX) other penalty when motif has a nucleotide the sequence does not
    inputBinding:
      position: 10
      prefix: --dextend=
      separate: false
  - id: strand
    type:
      - 'null'
      - string
    doc: limit processing to the forward or reverse strand of the sequence
    inputBinding:
      position: 10
      prefix: --strand=
      separate: false
  - id: head
    type:
      - 'null'
      - int
    doc: limit the number of input sequences
    inputBinding:
      position: 10
      prefix: --head=
      separate: false
  - id: progress
    type:
      - 'null'
      - int
    doc: report processing of every nth sequence
    inputBinding:
      position: 10
      prefix: --progress=
      separate: false
  - id: allocate_aligner
    type:
      - 'null'
      - int
    doc: suggest space (bytes) for aligner data structures
    inputBinding:
      position: 10
      prefix: --allocate:aligner=
      separate: false
  - id: allocate_sequence
    type:
      - 'null'
      - int
    doc: suggest space (bytes) for sequence nucleotides
    inputBinding:
      position: 10
      prefix: --allocate:sequence=
      separate: false
  - id: allocate_sequencename
    type:
      - 'null'
      - int
    doc: suggest space (bytes) for sequence name
    inputBinding:
      position: 10
      prefix: --allocate:sequencename=
      separate: false
  - id: allocate_debridger
    type:
      - 'null'
      - int
    doc: suggest space (bytes) for debridger data structures
    inputBinding:
      position: 10
      prefix: --allocate:debridger=
      separate: false
  - id: allocate_clump
    type:
      - 'null'
      - int
    doc: suggest space (bytes) for error clump data structures
    inputBinding:
      position: 10
      prefix: --allocate:clump=
      separate: false
  - id: positionalevents
    type:
      - 'null'
      - boolean
    doc: show match/mismatch/insert/delete counts by motif position (independent
      of --stats=events)
    inputBinding:
      position: 10
      prefix: --positionalevents
  - id: showforward
    type:
      - 'null'
      - boolean
    doc: always show the match in motif-forward orientation
    inputBinding:
      position: 10
      prefix: --showforward
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
stdin: $(inputs.fasta_file.path)
stdout: ncrf_NCRF.out
