cwlVersion: v1.2
class: CommandLineTool
baseCommand: dicey search
label: dicey_search
doc: "Generic options:\n\nTool homepage: https://github.com/gear-genomics/dicey"
inputs:
  - id: sequences
    type: File
    doc: sequences.fasta
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - Directory
    doc: primer3 config directory
    inputBinding:
      position: 102
      prefix: --config
  - id: cut_temp
    type:
      - 'null'
      - int
    doc: min. primer melting temperature
    inputBinding:
      position: 102
      prefix: --cutTemp
  - id: cutoff_penalty
    type:
      - 'null'
      - int
    doc: max. penalty for products (-1 = keep all)
    inputBinding:
      position: 102
      prefix: --cutoffPenalty
  - id: distance
    type:
      - 'null'
      - int
    doc: neighborhood distance
    inputBinding:
      position: 102
      prefix: --distance
  - id: divalent
    type:
      - 'null'
      - float
    doc: concentration of divalent ions in mMol
    inputBinding:
      position: 102
      prefix: --divalent
  - id: dna
    type:
      - 'null'
      - float
    doc: concentration of annealing(!) Oligos in nMol
    inputBinding:
      position: 102
      prefix: --dna
  - id: dntp
    type:
      - 'null'
      - float
    doc: the sum of all dNTPs in mMol
    inputBinding:
      position: 102
      prefix: --dntp
  - id: enttemp
    type:
      - 'null'
      - int
    doc: temperature for entropie and entalpie calculation in Celsius
    inputBinding:
      position: 102
      prefix: --enttemp
  - id: genome
    type: File
    doc: genome file
    inputBinding:
      position: 102
      prefix: --genome
  - id: hamming
    type:
      - 'null'
      - boolean
    doc: use hamming neighborhood instead of edit distance
    inputBinding:
      position: 102
      prefix: --hamming
  - id: kmer
    type:
      - 'null'
      - int
    doc: k-mer size
    inputBinding:
      position: 102
      prefix: --kmer
  - id: max_neighborhood
    type:
      - 'null'
      - int
    doc: max. neighborhood size
    inputBinding:
      position: 102
      prefix: --maxNeighborhood
  - id: max_product_size
    type:
      - 'null'
      - int
    doc: max. PCR Product size
    inputBinding:
      position: 102
      prefix: --maxProdSize
  - id: maxmatches
    type:
      - 'null'
      - int
    doc: max. number of matches per k-mer
    inputBinding:
      position: 102
      prefix: --maxmatches
  - id: monovalent
    type:
      - 'null'
      - float
    doc: concentration of monovalent ions in mMol
    inputBinding:
      position: 102
      prefix: --monovalent
  - id: penalty_length
    type:
      - 'null'
      - float
    doc: multiplication factor for amplicon length penalty
    inputBinding:
      position: 102
      prefix: --penaltyLength
  - id: penalty_tm_diff
    type:
      - 'null'
      - float
    doc: multiplication factor for deviation of primer Tm penalty
    inputBinding:
      position: 102
      prefix: --penaltyTmDiff
  - id: penalty_tm_mismatch
    type:
      - 'null'
      - float
    doc: multiplication factor for Tm pair difference penalty
    inputBinding:
      position: 102
      prefix: --penaltyTmMismatch
  - id: pruneprimer
    type:
      - 'null'
      - string
    doc: prune primer threshold
    inputBinding:
      position: 102
      prefix: --pruneprimer
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
