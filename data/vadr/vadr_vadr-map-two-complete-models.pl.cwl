cwlVersion: v1.2
class: CommandLineTool
baseCommand: vadr-map-two-complete-models.pl
label: vadr_vadr-map-two-complete-models.pl
doc: "Print the position-by-position map of one complete model onto another, from a model map (mmap) file.\n\nTool homepage: https://github.com/ncbi/vadr"
inputs:
  - id: mmap_file
    type: File
    doc: model map (mmap) file with the pairwise alignments of the models
    inputBinding:
      position: 1
  - id: model_from
    type: string
    doc: model to map positions from
    inputBinding:
      position: 2
  - id: model_to
    type: string
    doc: model to map positions to
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Tab-delimited table of positions of the first model and their positions in the second model (negative values are gaps in the second model)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vadr:1.6.4--pl5321h031d066_0
stdout: vadr_vadr-map-two-complete-models.pl.out
