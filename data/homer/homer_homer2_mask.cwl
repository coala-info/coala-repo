cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - homer2
  - mask
label: homer_homer2_mask
doc: "Remove (mask) instances of motifs in a set of sequences (homer2)\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
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
    doc: 'output tab delimited sequence file (default: standard output)'
    inputBinding:
      position: 103
      prefix: '-o'
  - id: m
    type:
      - 'null'
      - File
    doc: 'motif file with the motifs to mask'
    inputBinding:
      position: 103
      prefix: '-m'
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
outputs:
  - id: masked_stdout
    type: stdout
    doc: 'Masked sequences (standard output, empty when -o is used)'
  - id: masked_file
    type:
      - 'null'
      - File
    doc: 'Masked sequences written with -o'
    outputBinding:
      glob: $(inputs.o)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_homer2_mask.out
