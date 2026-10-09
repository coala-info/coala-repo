cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - homer2
  - find
label: homer_homer2_find
doc: "Find instances of motifs in a set of sequences (homer2)\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs:
  - id: s
    type:
      - 'null'
      - File
    doc: 'tab delimited sequence file (alternative to -i)'
    inputBinding:
      position: 103
      prefix: '-s'
  - id: i
    type:
      - 'null'
      - File
    doc: 'input FASTA file (alternative to -s)'
    inputBinding:
      position: 103
      prefix: '-i'
  - id: o
    type:
      - 'null'
      - string
    doc: 'output file (default: standard output)'
    inputBinding:
      position: 103
      prefix: '-o'
  - id: m
    type:
      - 'null'
      - File
    doc: 'motif file with the motifs to find instances of'
    inputBinding:
      position: 103
      prefix: '-m'
  - id: offset
    type:
      - 'null'
      - int
    doc: 'offset to report motif instances from (default: midpoint)'
    inputBinding:
      position: 103
      prefix: '-offset'
  - id: strand
    type:
      - 'null'
      - string
    doc: 'search for motifs on a specific strand: +, - or both (default: both)'
    inputBinding:
      position: 103
      prefix: '-strand'
  - id: p
    type:
      - 'null'
      - int
    doc: 'number of processors to use (default: 1)'
    inputBinding:
      position: 103
      prefix: '-p'
  - id: mscore
    type:
      - 'null'
      - boolean
    doc: 'report the best motif score per sequence instead of sites'
    inputBinding:
      position: 103
      prefix: '-mscore'
outputs:
  - id: sites_stdout
    type: stdout
    doc: 'Motif instances (standard output, empty when -o is used)'
  - id: sites_file
    type:
      - 'null'
      - File
    doc: 'Motif instances written with -o'
    outputBinding:
      glob: $(inputs.o)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_homer2_find.out
