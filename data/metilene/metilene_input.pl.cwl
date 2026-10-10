cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metilene_input.pl
label: metilene_input.pl
doc: "Merge sorted bedGraph files of two groups into the input matrix of metilene
  (uses bedtools).\n\nTool homepage: http://www.bioinf.uni-leipzig.de/Software/metilene"
inputs:
  - id: in1
    type:
      type: array
      items: File
    doc: comma-seperated list of sorted (!) bedgraph input files of group 1
    inputBinding:
      position: 101
      prefix: --in1
      itemSeparator: ','
  - id: in2
    type:
      type: array
      items: File
    doc: comma-seperated list of sorted (!) bedgraph input files of group 2
    inputBinding:
      position: 101
      prefix: --in2
      itemSeparator: ','
  - id: h1
    type:
      - 'null'
      - string
    doc: 'identifier of group 1 (default: g1)'
    inputBinding:
      position: 101
      prefix: --h1
  - id: h2
    type:
      - 'null'
      - string
    doc: 'identifier of group 2 (default: g2)'
    inputBinding:
      position: 101
      prefix: --h2
  - id: bedtools
    type:
      - 'null'
      - string
    doc: 'path/executable of bedtools executable (default: in PATH)'
    inputBinding:
      position: 101
      prefix: -b
  - id: out
    type: string
    default: metilene_g1_g2.input
    doc: 'path/file of out file (metilene input) (default: metilene_g1_g2.input)'
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: output
    type: File
    doc: metilene input matrix
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metilene:0.2.9--h7b50bb2_0
