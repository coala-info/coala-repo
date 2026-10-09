cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - homer2
  - norm
label: homer_homer2_norm
doc: "Normalize background sequences to remove short oligo enrichment and write a new weighted group file (homer2)\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs:
  - id: s
    type:
      - 'null'
      - File
    doc: 'tab delimited sequence file (use with -g), or give FASTA files with -i'
    inputBinding:
      position: 103
      prefix: '-s'
  - id: g
    type:
      - 'null'
      - File
    doc: 'group file with sequence group and weight assignments (use with -s)'
    inputBinding:
      position: 103
      prefix: '-g'
  - id: i
    type:
      - 'null'
      - File
    doc: 'input FASTA file (alternative to -s/-g)'
    inputBinding:
      position: 103
      prefix: '-i'
  - id: b
    type:
      - 'null'
      - File
    doc: 'background FASTA file (use with -i)'
    inputBinding:
      position: 103
      prefix: '-b'
  - id: o
    type:
      - 'null'
      - string
    doc: 'output weighted group file (default: standard output)'
    inputBinding:
      position: 103
      prefix: '-o'
  - id: strand
    type:
      - 'null'
      - string
    doc: 'search for motifs on a specific strand: +, - or both (default: both)'
    inputBinding:
      position: 103
      prefix: '-strand'
  - id: nlen
    type:
      - 'null'
      - int
    doc: 'length of lower-order oligos to normalize (default: 0)'
    inputBinding:
      position: 103
      prefix: '-nlen'
  - id: nout
    type:
      - 'null'
      - string
    doc: 'output normalization weights to this file'
    inputBinding:
      position: 103
      prefix: '-nout'
  - id: nmax
    type:
      - 'null'
      - int
    doc: 'maximum normalization iterations (default: 160)'
    inputBinding:
      position: 103
      prefix: '-nmax'
  - id: neutral
    type:
      - 'null'
      - boolean
    doc: 'set target/background to neutral frequencies, i.e. 25%, 6.25%, etc.'
    inputBinding:
      position: 103
      prefix: '-neutral'
  - id: p
    type:
      - 'null'
      - int
    doc: 'number of processors to use (default: 1)'
    inputBinding:
      position: 103
      prefix: '-p'
outputs:
  - id: group_stdout
    type: stdout
    doc: 'Weighted group file (standard output, empty when -o is used)'
  - id: group_file
    type:
      - 'null'
      - File
    doc: 'Weighted group file written with -o'
    outputBinding:
      glob: $(inputs.o)
  - id: normalization_weights
    type:
      - 'null'
      - File
    doc: 'Normalization weights (-nout)'
    outputBinding:
      glob: $(inputs.nout)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_homer2_norm.out
