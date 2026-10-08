cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - meryl-analyze
label: meryl_analyze
doc: "Analyze a meryl database: histograms of the G and C counts (-gc) or of the 2-mer microsatellite GA and TC counts (-ga) of each kmer.\n\nTool homepage: https://github.com/marbl/meryl"
inputs:
  - id: mers
    type: Directory
    doc: "Meryl database to analyze (-mers)"
    inputBinding:
      position: 1
      prefix: -mers
  - id: prefix
    type: string
    doc: "Prefix for the output files (-prefix)"
    inputBinding:
      position: 2
      prefix: -prefix
  - id: ga
    type:
      - 'null'
      - boolean
    doc: "Generate a histogram of 2-mer microsatellite GA counts; TC counts and the combined GA_TC are written as well (-ga). Only one report type runs; the last of -ga and -gc wins"
    inputBinding:
      position: 3
      prefix: -ga
  - id: gc
    type:
      - 'null'
      - boolean
    doc: "Generate a histogram of G and C counts (-gc). Only one report type runs; the last of -ga and -gc wins"
    inputBinding:
      position: 4
      prefix: -gc
outputs:
  - id: histograms
    type:
      type: array
      items: File
    doc: "Histogram files: score (out of k) <tab> kmer multiplicity <tab> count"
    outputBinding:
      glob: $(inputs.prefix).*.hist
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    coresMin: 1
    ramMin: 2048
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meryl:1.4.1--h9948957_2
