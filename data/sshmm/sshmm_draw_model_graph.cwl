cwlVersion: v1.2
class: CommandLineTool
baseCommand: draw_model_graph
label: sshmm_draw_model_graph
doc: "Takes a ssHMM model file in XML format and produces a model graph in PNG format.\n\
  \nTool homepage: https://github.molgen.mpg.de/heller/ssHMM"
inputs:
  - id: model
    type: File
    doc: model file in XML format
    inputBinding:
      position: 1
  - id: sequence_number
    type: int
    doc: number of training sequences that were used to generate the model. This
      number can be found in the verbose log file.
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: model graph output
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sshmm:1.0.7--py27_0
