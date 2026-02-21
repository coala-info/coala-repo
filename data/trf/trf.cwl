cwlVersion: v1.2
class: CommandLineTool
baseCommand: trf
label: trf
doc: "Tandem Repeats Finder: locates and displays tandem repeats in DNA sequences.\n
  \nTool homepage: https://tandem.bu.edu/trf/trf.html"
inputs:
  - id: file
    type: File
    doc: sequences input file (FASTA format)
    inputBinding:
      position: 1
  - id: match
    type: int
    doc: matching weight
    inputBinding:
      position: 2
  - id: mismatch
    type: int
    doc: mismatching penalty
    inputBinding:
      position: 3
  - id: delta
    type: int
    doc: indel penalty
    inputBinding:
      position: 4
  - id: pm
    type: int
    doc: match probability (whole number)
    inputBinding:
      position: 5
  - id: pi
    type: int
    doc: indel probability (whole number)
    inputBinding:
      position: 6
  - id: minscore
    type: int
    doc: minimum alignment score to report
    inputBinding:
      position: 7
  - id: max_period
    type: int
    doc: maximum period size to report. Must be between 1 and 2000, inclusive
    inputBinding:
      position: 8
  - id: data_file
    type:
      - 'null'
      - boolean
    doc: data file
    inputBinding:
      position: 109
      prefix: -d
  - id: flanking_sequence
    type:
      - 'null'
      - boolean
    doc: flanking sequence
    inputBinding:
      position: 109
      prefix: -f
  - id: masked_sequence_file
    type:
      - 'null'
      - boolean
    doc: masked sequence file
    inputBinding:
      position: 109
      prefix: -m
  - id: max_tr_length
    type:
      - 'null'
      - int
    doc: maximum TR length expected (in millions) (eg, -l 3 or -l=3 for 3 million)
    inputBinding:
      position: 109
      prefix: -l
  - id: ngs
    type:
      - 'null'
      - boolean
    doc: more compact .dat output on multisequence files, returns 0 on success. Output
      is printed to the screen, not a file.
    inputBinding:
      position: 109
      prefix: -ngs
  - id: no_redundancy
    type:
      - 'null'
      - boolean
    doc: no redundancy elimination
    inputBinding:
      position: 109
      prefix: -r
  - id: suppress_html
    type:
      - 'null'
      - boolean
    doc: suppress html output
    inputBinding:
      position: 109
      prefix: -h
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trf:4.10.0rc2--h7b50bb2_0
stdout: trf.out
