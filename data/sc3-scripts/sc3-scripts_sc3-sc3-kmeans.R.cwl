cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/sc3-sc3-kmeans.R
label: sc3-scripts_sc3-sc3-kmeans.R
doc: "Performs k-means clustering on a SC3 SingleCellExperiment object.\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts"
inputs:
  - id: input_object_file
    type: File
    doc: File name in which a transformed SC3 'SingleCellExperiment' object has 
      been stored after processed with sc3_calc_transfs()
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: ks
    type: string
    doc: A comma-separated string or single value representing the number of 
      clusters k to be used for SC3 clustering.
    inputBinding:
      position: 101
      prefix: --ks
outputs:
  - id: output_object_file
    type: File
    doc: File name for R object of type 'SingleCellExperiment' from SC3 in which
      to store the kmeans clustering as metadata.
    outputBinding:
      glob: $(inputs.output_object_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
