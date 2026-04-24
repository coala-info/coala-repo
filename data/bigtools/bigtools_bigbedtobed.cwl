cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigbedtobed
label: bigtools_bigbedtobed
doc: "Converts a bigBed file to a BED file.\n\nTool homepage: https://github.com/jackh726/bigtools/"
inputs:
  - id: input
    type: File
    doc: The bigBed file to convert.
    inputBinding:
      position: 1
  - id: chrom
    type:
      - 'null'
      - string
    doc: The chromosome to extract.
    inputBinding:
      position: 102
      prefix: -c
  - id: end
    type:
      - 'null'
      - int
    doc: The end position to extract.
    inputBinding:
      position: 102
      prefix: -e
  - id: n_threads
    type:
      - 'null'
      - int
    doc: The number of threads to use.
    inputBinding:
      position: 102
      prefix: -t
  - id: start
    type:
      - 'null'
      - int
    doc: The start position to extract.
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output
    type: File
    doc: The output BED file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigtools:0.5.6--hc1c3326_1
