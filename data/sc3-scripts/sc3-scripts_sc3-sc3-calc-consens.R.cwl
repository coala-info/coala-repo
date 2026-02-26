cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/sc3-sc3-calc-consens.R
label: sc3-scripts_sc3-sc3-calc-consens.R
doc: "Calculates the consensus matrix for SC3.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts"
inputs:
  - id: input_object_file
    type: File
    doc: File name in which a SC3 'SingleCellExperiment' object has been stored 
      after kmeans clustering.
    inputBinding:
      position: 101
      prefix: --input-object-file
outputs:
  - id: output_text_file
    type:
      - 'null'
      - File
    doc: Text file name in which to store clusters, one column for every k 
      value.
    outputBinding:
      glob: $(inputs.output_text_file)
  - id: output_object_file
    type:
      - 'null'
      - File
    doc: File name for R object of type 'SingleCellExperiment' from SC3 in which
      to store the consensus matrix.
    outputBinding:
      glob: $(inputs.output_object_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
