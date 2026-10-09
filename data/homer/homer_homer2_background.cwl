cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - homer2
  - background
label: homer_homer2_background
doc: "Generate or select background sequences that match properties of a set of target sequences (homer2)\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs:
  - id: i
    type:
      - 'null'
      - File
    doc: 'target sequences FASTA file'
    inputBinding:
      position: 103
      prefix: '-i'
  - id: p
    type:
      - 'null'
      - File
    doc: 'target positions as a BED or HOMER peak file with genomic coordinates (alternative to -i)'
    inputBinding:
      position: 103
      prefix: '-p'
  - id: model
    type:
      - 'null'
      - boolean
    doc: 'generate sequences using a model instead of extracting real background sequences'
    inputBinding:
      position: 103
      prefix: '-model'
  - id: g
    type:
      - 'null'
      - File
    doc: 'genome FASTA file or sequence resource to select sequences from'
    inputBinding:
      position: 103
      prefix: '-g'
  - id: b
    type:
      - 'null'
      - File
    doc: 'explicit set of background sequences (FASTA) to choose from'
    inputBinding:
      position: 103
      prefix: '-b'
  - id: bg
    type:
      - 'null'
      - File
    doc: 'explicit set of background positions (BED) to choose from'
    inputBinding:
      position: 103
      prefix: '-bg'
  - id: bgr
    type:
      - 'null'
      - File
    doc: 'regions of the genome (BED) to select background sequences from'
    inputBinding:
      position: 103
      prefix: '-bgr'
  - id: size
    type:
      - 'null'
      - int
    doc: 'size of the regions to consider in the background (default: average length of the target sequences)'
    inputBinding:
      position: 103
      prefix: '-size'
  - id: N
    type:
      - 'null'
      - int
    doc: 'number of background sequences to select (default: 100000)'
    inputBinding:
      position: 103
      prefix: '-N'
  - id: NN
    type:
      - 'null'
      - int
    doc: 'number of background sequences for the initial screen from the genome (default: 100000000)'
    inputBinding:
      position: 103
      prefix: '-NN'
  - id: mask
    type:
      - 'null'
      - boolean
    doc: 'mask lowercase (soft masked) sequence (default: use all sequences)'
    inputBinding:
      position: 103
      prefix: '-mask'
  - id: nbins
    type:
      - 'null'
      - int
    doc: 'number of bins to segregate sequences into for GC selection (default: 10)'
    inputBinding:
      position: 103
      prefix: '-nbins'
  - id: nsubBins
    type:
      - 'null'
      - int
    doc: 'number of bins to segregate sequences into for positional frequencies (default: 10)'
    inputBinding:
      position: 103
      prefix: '-nsubBins'
  - id: maxFractionN
    type:
      - 'null'
      - float
    doc: 'maximum fraction of a sequence that can be N and still used (default: 0.5)'
    inputBinding:
      position: 103
      prefix: '-maxFractionN'
  - id: allowTargetOverlaps
    type:
      - 'null'
      - boolean
    doc: 'allow selected background sequences from a genome to overlap targets'
    inputBinding:
      position: 103
      prefix: '-allowTargetOverlaps'
  - id: allowBgOverlaps
    type:
      - 'null'
      - boolean
    doc: 'allow selected background sequences from a genome to overlap one another'
    inputBinding:
      position: 103
      prefix: '-allowBgOverlaps'
  - id: strand
    type:
      - 'null'
      - boolean
    doc: 'allow sequences to overlap if they are on separate strands'
    inputBinding:
      position: 103
      prefix: '-strand'
  - id: pkmer
    type:
      - 'null'
      - int
    doc: 'match positional kmer content'
    inputBinding:
      position: 103
      prefix: '-pkmer'
  - id: ikmer
    type:
      - 'null'
      - int
    doc: 'match overall kmer content (position independent)'
    inputBinding:
      position: 103
      prefix: '-ikmer'
  - id: excludeNs
    type:
      - 'null'
      - boolean
    doc: 'exclude kmers with Ns when selecting background sequences (default for selection)'
    inputBinding:
      position: 103
      prefix: '-excludeNs'
  - id: includeNs
    type:
      - 'null'
      - boolean
    doc: 'include kmers with Ns (default when generating sequences with -model)'
    inputBinding:
      position: 103
      prefix: '-includeNs'
  - id: pscore
    type:
      - 'null'
      - string
    doc: 'output BED file for the initial pscores'
    inputBinding:
      position: 103
      prefix: '-pscore'
  - id: maxIterations
    type:
      - 'null'
      - int
    doc: 'maximum iterations (default: 20)'
    inputBinding:
      position: 103
      prefix: '-maxIterations'
  - id: overlapIteration
    type:
      - 'null'
      - int
    doc: 'iteration to start enforcing no overlaps (default: 5)'
    inputBinding:
      position: 103
      prefix: '-overlapIteration'
  - id: decayRate
    type:
      - 'null'
      - float
    doc: 'selection rate per iteration (default: 0.75)'
    inputBinding:
      position: 103
      prefix: '-decayRate'
  - id: seed
    type:
      - 'null'
      - int
    doc: 'seed for the random number generator (default: uses time)'
    inputBinding:
      position: 103
      prefix: '-seed'
  - id: o
    type:
      - 'null'
      - string
    doc: 'output prefix (default: out)'
    inputBinding:
      position: 103
      prefix: '-o'
  - id: gs
    type:
      - 'null'
      - boolean
    doc: 'include homer-style group and sequence output files'
    inputBinding:
      position: 103
      prefix: '-gs'
outputs:
  - id: log
    type: stdout
    doc: 'Program messages written to standard output'
  - id: background_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Background output files (<prefix>.*)'
    outputBinding:
      glob: '$(inputs.o ? inputs.o : "out")*'
  - id: pscore_file
    type:
      - 'null'
      - File
    doc: 'Initial pscores (-pscore)'
    outputBinding:
      glob: $(inputs.pscore)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_homer2_background.out
