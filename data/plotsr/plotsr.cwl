cwlVersion: v1.2
class: CommandLineTool
baseCommand: plotsr
label: plotsr
doc: "plotsr is a tool to visualize structural variations and synteny between multiple
  genomes. It uses the structural rearrangements identified by SyRI and plots them
  in a publication-quality figure.\n\nTool homepage: https://github.com/schneebergerlab/plotsr"
inputs:
  - id: cfg
    type:
      - 'null'
      - File
    doc: Configuration file for plot styling
    inputBinding:
      position: 101
      prefix: --cfg
  - id: format
    type:
      - 'null'
      - string
    doc: Output figure format (pdf, png, svg)
    inputBinding:
      position: 101
      prefix: --format
  - id: genomes
    type: File
    doc: File containing genome IDs and paths
    inputBinding:
      position: 101
      prefix: --genomes
  - id: itx
    type:
      - 'null'
      - boolean
    doc: Plot intra-chromosomal translocations
    inputBinding:
      position: 101
      prefix: --itx
  - id: markers
    type:
      - 'null'
      - File
    doc: BED file containing markers to be plotted on the genomes
    inputBinding:
      position: 101
      prefix: --markers
  - id: sr
    type:
      type: array
      items: File
    doc: Structural rearrangement files (syri.out) identified by SyRI
    inputBinding:
      position: 101
      prefix: --sr
  - id: tracks
    type:
      - 'null'
      - File
    doc: File containing paths to tracks (BED, BedGraph, or BigWig) to be 
      plotted
    inputBinding:
      position: 101
      prefix: --tracks
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output figure name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plotsr:1.1.1--pyh7cba7a3_0
