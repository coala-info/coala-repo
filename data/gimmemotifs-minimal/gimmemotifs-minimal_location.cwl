cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gimme
  - location
label: gimmemotifs-minimal_location
doc: "Motif location histograms\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs:
  - id: size
    type:
      - 'null'
      - int
    doc: "Set size to W (default: determined from fastafile)"
    inputBinding:
      position: 1
      prefix: -s
  - id: ids
    type:
      - 'null'
      - string
    doc: "Comma-separated list of motif ids to plot (default is all ids)"
    inputBinding:
      position: 1
      prefix: -i
  - id: cutoff
    type:
      - 'null'
      - float
    doc: "Cutoff for motif scanning (default 0.95)"
    inputBinding:
      position: 1
      prefix: -c
  - id: pfmfile
    type: File
    doc: "File with pfms"
    inputBinding:
      position: 100
  - id: fafile
    type: File
    doc: "Fasta formatted file"
    inputBinding:
      position: 101
outputs:
  - id: histograms
    type: File[]
    doc: "Location histogram of each motif"
    outputBinding:
      glob: '*_histogram*'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
