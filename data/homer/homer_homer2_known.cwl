cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - homer2
  - known
label: homer_homer2_known
doc: "Find the enrichment of known motifs in a set of sequences (homer2)\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
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
    doc: 'output enrichment file (default: standard output)'
    inputBinding:
      position: 103
      prefix: '-o'
  - id: m
    type:
      - 'null'
      - File
    doc: 'known motif file to check enrichment for'
    inputBinding:
      position: 103
      prefix: '-m'
  - id: mout
    type:
      - 'null'
      - string
    doc: 'output updated motifs with statistics to this file'
    inputBinding:
      position: 103
      prefix: '-mout'
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
  - id: cache
    type:
      - 'null'
      - int
    doc: 'size in MB of the statistics cache (default: 500)'
    inputBinding:
      position: 103
      prefix: '-cache'
  - id: p
    type:
      - 'null'
      - int
    doc: 'number of processors to use (default: 1)'
    inputBinding:
      position: 103
      prefix: '-p'
  - id: opt
    type:
      - 'null'
      - boolean
    doc: 'optimize the degeneracy threshold to get the best enrichment (use -mout to get the motifs)'
    inputBinding:
      position: 103
      prefix: '-opt'
  - id: siteReduce
    type:
      - 'null'
      - float
    doc: 'eliminate redundant motifs sharing more than this percent of sites'
    inputBinding:
      position: 103
      prefix: '-siteReduce'
  - id: maxBack
    type:
      - 'null'
      - float
    doc: 'maximum fraction of the background that motifs may contain (default: 0.5)'
    inputBinding:
      position: 103
      prefix: '-maxBack'
outputs:
  - id: enrichment_stdout
    type: stdout
    doc: 'Motif enrichment table (standard output, empty when -o is used)'
  - id: enrichment_file
    type:
      - 'null'
      - File
    doc: 'Motif enrichment table written with -o'
    outputBinding:
      glob: $(inputs.o)
  - id: updated_motifs
    type:
      - 'null'
      - File
    doc: 'Motifs with statistics (-mout)'
    outputBinding:
      glob: $(inputs.mout)
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
stdout: homer_homer2_known.out
