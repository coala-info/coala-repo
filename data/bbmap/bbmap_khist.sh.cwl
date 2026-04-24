cwlVersion: v1.2
class: CommandLineTool
baseCommand: bbmap_khist.sh
label: bbmap_khist
doc: "Kmer normalization and histogram generation tool (jgi.KmerNormalize)\n\nTool
  homepage: https://sourceforge.net/projects/bbmap"
inputs:
  - id: bits
    type:
      - 'null'
      - int
    doc: Number of bits per cell in the bloom filter
    inputBinding:
      position: 101
      prefix: bits
  - id: dr
    type:
      - 'null'
      - boolean
    doc: Discard reads
    inputBinding:
      position: 101
      prefix: dr
  - id: ecc
    type:
      - 'null'
      - boolean
    doc: Error correction
    inputBinding:
      position: 101
      prefix: ecc
  - id: hashes
    type:
      - 'null'
      - int
    doc: Number of hashes
    inputBinding:
      position: 101
      prefix: hashes
  - id: keepall
    type:
      - 'null'
      - boolean
    doc: Keep all kmers
    inputBinding:
      position: 101
      prefix: keepall
  - id: mindepth
    type:
      - 'null'
      - int
    doc: Minimum depth
    inputBinding:
      position: 101
      prefix: mindepth
  - id: minkmers
    type:
      - 'null'
      - int
    doc: Minimum kmers
    inputBinding:
      position: 101
      prefix: minkmers
  - id: minprob
    type:
      - 'null'
      - float
    doc: Minimum probability
    inputBinding:
      position: 101
      prefix: minprob
  - id: minqual
    type:
      - 'null'
      - int
    doc: Minimum quality
    inputBinding:
      position: 101
      prefix: minqual
  - id: passes
    type:
      - 'null'
      - int
    doc: Number of passes
    inputBinding:
      position: 101
      prefix: passes
  - id: prefilter
    type:
      - 'null'
      - boolean
    doc: Use a prefilter
    inputBinding:
      position: 101
      prefix: prefilter
outputs:
  - id: hist
    type:
      - 'null'
      - File
    doc: Output kmer histogram file
    outputBinding:
      glob: $(inputs.hist)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
