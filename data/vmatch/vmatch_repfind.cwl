cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - repfind.pl
label: vmatch_repfind
doc: "Find maximal repeats in a sequence file (builds the index and runs vmatch).

Tool homepage: http://www.vmatch.de/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: sequence_file
    type: File
    doc: "sequence file to search for repeats"
    inputBinding:
      position: 200
  - id: f
    type:
      - 'null'
      - boolean
    doc: "compute maximal forward repeats"
    inputBinding:
      position: 101
      prefix: -f
  - id: p
    type:
      - 'null'
      - boolean
    doc: "compute maximal palindromes"
    inputBinding:
      position: 101
      prefix: -p
  - id: repeat_length
    type:
      - 'null'
      - int
    doc: "specify that repeats must have the given length"
    inputBinding:
      position: 101
      prefix: -l
  - id: hamming
    type:
      - 'null'
      - int
    doc: "search for repeats up to the given hamming distance"
    inputBinding:
      position: 101
      prefix: -h
  - id: edit
    type:
      - 'null'
      - int
    doc: "search for repeats up to the given edit distance"
    inputBinding:
      position: 101
      prefix: -e
  - id: seedsize
    type:
      - 'null'
      - int
    doc: "set the seed size"
    inputBinding:
      position: 101
      prefix: -seedsize
  - id: allmax
    type:
      - 'null'
      - boolean
    doc: "show all maximal repeats in the order of their computation"
    inputBinding:
      position: 101
      prefix: -allmax
  - id: best
    type:
      - 'null'
      - int
    doc: "show the repeats with smallest E-value (default best 50)"
    inputBinding:
      position: 101
      prefix: -best
  - id: s
    type:
      - 'null'
      - boolean
    doc: "show the string content of the maximal repeats"
    inputBinding:
      position: 101
      prefix: -s
  - id: lw
    type:
      - 'null'
      - int
    doc: "format string output to given linewidth"
    inputBinding:
      position: 101
      prefix: -lw
  - id: iub
    type:
      - 'null'
      - boolean
    doc: "print pair of different residues in IUB format"
    inputBinding:
      position: 101
      prefix: -iub
  - id: nodistance
    type:
      - 'null'
      - boolean
    doc: "do not show distance values"
    inputBinding:
      position: 101
      prefix: -nodistance
  - id: noevalue
    type:
      - 'null'
      - boolean
    doc: "do not compute evalues"
    inputBinding:
      position: 101
      prefix: -noevalue
  - id: i
    type:
      - 'null'
      - boolean
    doc: "give info about number of different repeats"
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch_repfind.out
