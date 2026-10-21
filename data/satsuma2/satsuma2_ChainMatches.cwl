cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ChainMatches]
label: satsuma2_ChainMatches
doc: "Chains matches found by HomologyByXCorr via dynamic programming.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs:
  - id: input_file
    type: File
    doc: "XCorr input file (binary)"
    inputBinding:
      position: 1
      prefix: -i
  - id: output_file
    type: string
    doc: "output file (binary)"
    inputBinding:
      position: 2
      prefix: -o
  - id: min_len
    type: ['null', int]
    doc: "minimum length to force keep (def=220)"
    inputBinding:
      position: 3
      prefix: -min_len
  - id: min_id
    type: ['null', double]
    doc: "minimum identity to force keep (def=0.57)"
    inputBinding:
      position: 4
      prefix: -min_id
  - id: dups
    type: ['null', boolean]
    doc: "allow for duplications (def=0)"
    inputBinding:
      position: 5
      prefix: -dups
outputs:
  - id: chained_matches
    type: File
    doc: "Chained matches (binary XCorr file)"
    outputBinding:
      glob: "$(inputs.output_file)"
  - id: log
    type: stdout
    doc: "Standard output of the program"
stdout: chainmatches.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
