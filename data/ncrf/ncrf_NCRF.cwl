cwlVersion: v1.2
class: CommandLineTool
baseCommand: NCRF
label: ncrf_NCRF
doc: "Noise Cancelling Repeat Finder, to find tandem repeats in noisy reads\n\nTool
  homepage: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder"
inputs:
  - id: fasta_file
    type: File
    doc: fasta file containing sequences; read from stdin
    inputBinding:
      position: 1
  - id: motifs
    type:
      type: array
      items: string
    doc: dna repeat motif to search for
    inputBinding:
      position: 2
  - id: help_allocation
    type:
      - 'null'
      - boolean
    doc: show options relating to memory allocation
    inputBinding:
      position: 103
      prefix: --help=allocation
  - id: help_other
    type:
      - 'null'
      - boolean
    doc: show other, less frequently used options
    inputBinding:
      position: 103
      prefix: --help=other
  - id: help_scoring
    type:
      - 'null'
      - boolean
    doc: show options relating to alignment scoring
    inputBinding:
      position: 103
      prefix: --help=scoring
  - id: maxnoise
    type:
      - 'null'
      - float
    doc: (same as --minmratio but with 1-ratio)
    inputBinding:
      position: 103
      prefix: --maxnoise
  - id: minlength
    type:
      - 'null'
      - int
    doc: discard alignments that don't have long enough repeat
    inputBinding:
      position: 103
      prefix: --minlength
  - id: minmratio
    type:
      - 'null'
      - float
    doc: discard alignments with a low frequency of matches; ratio can be 
      between 0 and 1 (e.g. "0.85"), or can be expressed as a percentage (e.g. 
      "85%")
    inputBinding:
      position: 103
      prefix: --minmratio
  - id: minscore
    type:
      - 'null'
      - int
    doc: discard alignments that don't score high enough
    inputBinding:
      position: 103
      prefix: --minscore
  - id: positionalevents
    type:
      - 'null'
      - boolean
    doc: show match/mismatch/insert/delete counts by motif position (independent
      of --stats=events); this may be useful for detecting error non-uniformity,
      to separate perfect repeats from imperfect
    inputBinding:
      position: 103
      prefix: --positionalevents
  - id: stats
    type:
      - 'null'
      - string
    doc: show match/mismatch/insert/delete counts
    inputBinding:
      position: 103
      prefix: --stats
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
stdout: ncrf_NCRF.out
