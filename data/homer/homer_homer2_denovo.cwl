cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - homer2
  - denovo
label: homer_homer2_denovo
doc: "Discover motifs de novo in a set of sequences (homer2)\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
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
    doc: 'output motif file (default: standard output)'
    inputBinding:
      position: 103
      prefix: '-o'
  - id: len
    type:
      - 'null'
      - int
    doc: 'length of the motif to search for (default: 10)'
    inputBinding:
      position: 103
      prefix: '-len'
  - id: mis
    type:
      - 'null'
      - int
    doc: 'maximum number of mismatches in the global search phase (default: 2)'
    inputBinding:
      position: 103
      prefix: '-mis'
  - id: strand
    type:
      - 'null'
      - string
    doc: 'search for motifs on a specific strand: +, - or both (default: both)'
    inputBinding:
      position: 103
      prefix: '-strand'
  - id: stat
    type:
      - 'null'
      - string
    doc: 'enrichment statistic: hypergeo or binomial (default: binomial)'
    inputBinding:
      position: 103
      prefix: '-stat'
  - id: S
    type:
      - 'null'
      - int
    doc: 'total number of motifs to find (default: 25)'
    inputBinding:
      position: 103
      prefix: '-S'
  - id: olen
    type:
      - 'null'
      - int
    doc: 'length of lower-order oligos to normalize in the oligo table'
    inputBinding:
      position: 103
      prefix: '-olen'
  - id: oout
    type:
      - 'null'
      - string
    doc: 'output normalization weights to this file'
    inputBinding:
      position: 103
      prefix: '-oout'
  - id: omax
    type:
      - 'null'
      - int
    doc: 'maximum oligo normalization iterations (default: 160)'
    inputBinding:
      position: 103
      prefix: '-omax'
  - id: p
    type:
      - 'null'
      - int
    doc: 'number of processors to use (default: 1)'
    inputBinding:
      position: 103
      prefix: '-p'
  - id: nozoops
    type:
      - 'null'
      - boolean
    doc: 'skip proper zoops scoring at the end'
    inputBinding:
      position: 103
      prefix: '-nozoops'
  - id: tmp
    type:
      - 'null'
      - string
    doc: 'temporary results file (default: .tmp.motifs)'
    inputBinding:
      position: 103
      prefix: '-tmp'
  - id: oligos
    type:
      - 'null'
      - string
    doc: 'print the enrichment of individual oligos to this file'
    inputBinding:
      position: 103
      prefix: '-oligos'
  - id: opt
    type:
      - 'null'
      - File
    doc: 'motif file to expand/further optimize (skips the global phase)'
    inputBinding:
      position: 103
      prefix: '-opt'
  - id: fullMask
    type:
      - 'null'
      - boolean
    doc: 'as motifs are found, mask them from the original sequences (default; needs more memory)'
    inputBinding:
      position: 103
      prefix: '-fullMask'
  - id: quickMask
    type:
      - 'null'
      - boolean
    doc: 'as motifs are found, mask bound oligos only (old way)'
    inputBinding:
      position: 103
      prefix: '-quickMask'
  - id: e
    type:
      - 'null'
      - float
    doc: 'maximum expected motif instances per bp (default: 0.005)'
    inputBinding:
      position: 103
      prefix: '-e'
  - id: T
    type:
      - 'null'
      - int
    doc: 'number of trial matrices when optimizing (default: 10)'
    inputBinding:
      position: 103
      prefix: '-T'
  - id: blen
    type:
      - 'null'
      - int
    doc: 'number of bp on either side to check for redundancy (default: 1)'
    inputBinding:
      position: 103
      prefix: '-blen'
  - id: maxBack
    type:
      - 'null'
      - float
    doc: 'maximum fraction of the background that motifs may contain (default: 0.5)'
    inputBinding:
      position: 103
      prefix: '-maxBack'
  - id: minlp
    type:
      - 'null'
      - float
    doc: 'minimum significance of seeds to optimize (default: -10.000)'
    inputBinding:
      position: 103
      prefix: '-minlp'
  - id: cache
    type:
      - 'null'
      - int
    doc: 'size in MB of the statistics cache (default: 500)'
    inputBinding:
      position: 103
      prefix: '-cache'
outputs:
  - id: motifs_stdout
    type: stdout
    doc: 'Discovered motifs (standard output, empty when -o is used)'
  - id: motif_file
    type:
      - 'null'
      - File
    doc: 'Discovered motifs written with -o'
    outputBinding:
      glob: $(inputs.o)
  - id: normalization_weights
    type:
      - 'null'
      - File
    doc: 'Oligo normalization weights (-oout)'
    outputBinding:
      glob: $(inputs.oout)
  - id: oligo_enrichment
    type:
      - 'null'
      - File
    doc: 'Individual oligo enrichment (-oligos)'
    outputBinding:
      glob: $(inputs.oligos)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_homer2_denovo.out
