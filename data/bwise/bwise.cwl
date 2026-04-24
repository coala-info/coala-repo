cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwise
label: bwise
doc: "High order De Bruijn graph assembler\n\nTool homepage: https://github.com/Malfoy/BWISE"
inputs:
  - id: anchor_size
    type:
      - 'null'
      - int
    doc: Anchors size
    inputBinding:
      position: 101
      prefix: -a
  - id: fraction_anchor
    type:
      - 'null'
      - float
    doc: Fraction of the anchor that are indexed (default all, put 10 to index 
      one out of 10 anchors)
    inputBinding:
      position: 101
      prefix: -i
  - id: greedy_k2000
    type:
      - 'null'
      - boolean
    doc: Greedy contig extension
    inputBinding:
      position: 101
      prefix: -g
  - id: haplo_mode
    type:
      - 'null'
      - boolean
    doc: Produce a haploid assembly
    inputBinding:
      position: 101
      prefix: -H
  - id: k_max
    type:
      - 'null'
      - int
    doc: an integer, largest k-mer size
    inputBinding:
      position: 101
      prefix: -K
  - id: k_min
    type:
      - 'null'
      - int
    doc: an integer, smallest k-mer size
    inputBinding:
      position: 101
      prefix: -k
  - id: kmer_coverage
    type:
      - 'null'
      - int
    doc: an integer, minimal unitig coverage for first cleaning
    inputBinding:
      position: 101
      prefix: -S
  - id: kmer_solidity
    type:
      - 'null'
      - int
    doc: an integer, k-mers present strictly less than this number of times in 
      the dataset will be discarded
    inputBinding:
      position: 101
      prefix: -s
  - id: mapping_effort
    type:
      - 'null'
      - int
    doc: Anchors to test for mapping
    inputBinding:
      position: 101
      prefix: -e
  - id: max_occurence
    type:
      - 'null'
      - int
    doc: maximal ccurence for an indexed anchor
    inputBinding:
      position: 101
      prefix: -A
  - id: missmatch_allowed
    type:
      - 'null'
      - int
    doc: missmatch allowed in mapping
    inputBinding:
      position: 101
      prefix: -m
  - id: nb_cores
    type:
      - 'null'
      - int
    doc: number of cores used
    inputBinding:
      position: 101
      prefix: -t
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: path to store the results
    inputBinding:
      position: 101
      prefix: -o
  - id: paired_readfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: input fasta or (compressed .gz if -c option is != 0) paired-end read 
      files. Several read files must be concatenated.
    inputBinding:
      position: 101
      prefix: -x
  - id: single_readfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: input fasta or (compressed .gz if -c option is != 0) single-end read 
      files. Several read files must be concatenated.
    inputBinding:
      position: 101
      prefix: -u
  - id: sr_coverage
    type:
      - 'null'
      - int
    doc: an integer, unitigs with less than S reads mapped is filtred
    inputBinding:
      position: 101
      prefix: -P
  - id: sr_solidity
    type:
      - 'null'
      - int
    doc: an integer, super-reads present strictly less than this number of times
      will be discarded
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwise:1.0.0--h8b12597_0
stdout: bwise.out
