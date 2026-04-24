cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dicey
  - hunt
label: dicey_hunt
doc: "Finds matches of a given sequence in a genome file.\n\nTool homepage: https://github.com/gear-genomics/dicey"
inputs:
  - id: sequence
    type: string
    doc: Sequence to search for
    inputBinding:
      position: 1
  - id: distance
    type:
      - 'null'
      - int
    doc: neighborhood distance
    inputBinding:
      position: 102
      prefix: --distance
  - id: forward
    type:
      - 'null'
      - boolean
    doc: only forward matches
    inputBinding:
      position: 102
      prefix: --forward
  - id: genome_file
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
  - id: max_matches
    type:
      - 'null'
      - int
    doc: max. number of matches
    inputBinding:
      position: 102
      prefix: --maxmatches
  - id: max_neighborhood
    type:
      - 'null'
      - int
    doc: max. neighborhood size
    inputBinding:
      position: 102
      prefix: --maxNeighborhood
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: gzipped output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
