cwlVersion: v1.2
class: CommandLineTool
baseCommand: [HomologyByXCorr]
label: satsuma2_HomologyByXCorr
doc: "Compares two sequences via cross-correlation.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs:
  - id: query_fasta
    type: File
    doc: "query fasta sequence"
    inputBinding:
      position: 1
      prefix: -q
  - id: target_fasta
    type: File
    doc: "target fasta sequence"
    inputBinding:
      position: 2
      prefix: -t
  - id: output_file
    type: string
    doc: "output file (binary); the help types this option as int, it is a file name"
    inputBinding:
      position: 3
      prefix: -o
  - id: query_id
    type: ['null', int]
    doc: "query sequence id (def=-1)"
    inputBinding:
      position: 4
      prefix: -cq
  - id: target_id
    type: ['null', int]
    doc: "target sequence id (def=-1)"
    inputBinding:
      position: 5
      prefix: -ct
  - id: min_length
    type: ['null', int]
    doc: "minimum alignment length (def=0)"
    inputBinding:
      position: 6
      prefix: -l
  - id: target_chunk
    type: ['null', int]
    doc: "target chunk size (def=4096)"
    inputBinding:
      position: 7
      prefix: -t_chunk
  - id: query_chunk
    type: ['null', int]
    doc: "query chunk size (def=4096)"
    inputBinding:
      position: 8
      prefix: -q_chunk
  - id: nblocks
    type: ['null', int]
    doc: "total number of blocks to process (when parallel) (def=0)"
    inputBinding:
      position: 9
      prefix: -nblocks
  - id: block
    type: ['null', int]
    doc: "block # to process (when parallel) (def=0)"
    inputBinding:
      position: 10
      prefix: -block
  - id: nblocks_query
    type: ['null', int]
    doc: "total number of QUERY blocks to process (when parallel) (def=0)"
    inputBinding:
      position: 11
      prefix: -nblocks_query
  - id: block_query
    type: ['null', int]
    doc: "QUERY block # to process (when parallel) (def=0)"
    inputBinding:
      position: 12
      prefix: -block_query
  - id: same_only
    type: ['null', boolean]
    doc: "only align sequences that have the same name. (def=0)"
    inputBinding:
      position: 13
      prefix: -same_only
  - id: min_prob
    type: ['null', double]
    doc: "minimum probability to keep match (def=0.9999)"
    inputBinding:
      position: 14
      prefix: -min_prob
  - id: guide
    type: ['null', File]
    doc: "XCorr input file (binary) to guide alignments (def=)"
    inputBinding:
      position: 15
      prefix: -guide
  - id: proteins
    type: ['null', boolean]
    doc: "translate seqeunces to proteins when aligning. (def=0)"
    inputBinding:
      position: 16
      prefix: -proteins
  - id: cutoff
    type: ['null', double]
    doc: "signal selection cutoff (def=1.8)"
    inputBinding:
      position: 17
      prefix: -cutoff
  - id: chain
    type: ['null', boolean]
    doc: "chain matches before writing them out (def=0)"
    inputBinding:
      position: 18
      prefix: -chain
  - id: select
    type: ['null', File]
    doc: "selection file (def=)"
    inputBinding:
      position: 19
      prefix: -select
  - id: pairs
    type: ['null', File]
    doc: "valid block pairs to process (def=)"
    inputBinding:
      position: 20
      prefix: -pairs
  - id: line
    type: ['null', double]
    doc: "pick one block and compare to the query (def=-1)"
    inputBinding:
      position: 21
      prefix: -line
outputs:
  - id: xcorr_matches
    type: File
    doc: "Cross-correlation matches (binary XCorr file)"
    outputBinding:
      glob: "$(inputs.output_file)"
  - id: log
    type: stdout
    doc: "Standard output of the program"
stdout: homologybyxcorr.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
