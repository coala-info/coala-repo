cwlVersion: v1.2
class: CommandLineTool
baseCommand: [FilterGridSeeds]
label: satsuma2_FilterGridSeeds
doc: "Finds seeds for the battleship search.\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs:
  - id: target_fasta
    type: File
    doc: "target fasta file"
    inputBinding:
      position: 1
      prefix: -t
  - id: query_fasta
    type: File
    doc: "query fasta file"
    inputBinding:
      position: 2
      prefix: -q
  - id: output_file
    type: string
    doc: "output file"
    inputBinding:
      position: 3
      prefix: -o
  - id: distance
    type: ['null', int]
    doc: "distance between seeds (def=1)"
    inputBinding:
      position: 4
      prefix: -distance
  - id: width
    type: ['null', int]
    doc: "width of the filter (def=2)"
    inputBinding:
      position: 5
      prefix: -w
  - id: self_alignment
    type: ['null', boolean]
    doc: "self-alignment (def=0)"
    inputBinding:
      position: 6
      prefix: -self
outputs:
  - id: seeds
    type: File
    doc: "Seed file (binary)"
    outputBinding:
      glob: "$(inputs.output_file)"
  - id: log
    type: stdout
    doc: "Standard output of the program"
stdout: filtergridseeds.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
