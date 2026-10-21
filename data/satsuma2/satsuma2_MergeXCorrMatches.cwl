cwlVersion: v1.2
class: CommandLineTool
baseCommand: [MergeXCorrMatches]
label: satsuma2_MergeXCorrMatches
doc: "Merges matches found by HomologyByXCorr.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
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
    doc: "output file (summary)"
    inputBinding:
      position: 3
      prefix: -o
  - id: qlt_output
    type: ['null', string]
    doc: "QLT-style output file (def=)"
    inputBinding:
      position: 4
      prefix: -qlt
  - id: input_file
    type: File
    doc: "XCorr input file (binary)"
    inputBinding:
      position: 5
      prefix: -i
  - id: query_offset
    type: ['null', int]
    doc: "offset of query sequence (def=0)"
    inputBinding:
      position: 6
      prefix: -q_offset
  - id: target_offset
    type: ['null', int]
    doc: "offset of target sequence (def=0)"
    inputBinding:
      position: 7
      prefix: -t_offset
  - id: reverse
    type: ['null', boolean]
    doc: "reverse query and target id's (def=0)"
    inputBinding:
      position: 8
      prefix: -reverse
  - id: min_score
    type: ['null', double]
    doc: "minimum score to accept (def=0.6)"
    inputBinding:
      position: 9
      prefix: -min_score
  - id: self_matches
    type: ['null', boolean]
    doc: "suppresses self-matches (def=0)"
    inputBinding:
      position: 10
      prefix: -self
outputs:
  - id: summary
    type: File
    doc: "Satsuma summary file"
    outputBinding:
      glob: "$(inputs.output_file)"
  - id: qlt
    type: ['null', File]
    doc: "QLT-style output file (when -qlt is set)"
    outputBinding:
      glob: "$(inputs.qlt_output)"
  - id: log
    type: stdout
    doc: "Standard output of the program"
stdout: mergexcorrmatches.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
