cwlVersion: v1.2
class: CommandLineTool
baseCommand: sc3-sc3-calc-dists.R
label: sc3-scripts_sc3-sc3-calc-dists.R
doc: "Calculates distances between cells.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts"
inputs:
  - id: input_object_file
    type: File
    doc: File name in which a serialized R SingleCellExperiment object where 
      object matrix found
    inputBinding:
      position: 101
      prefix: --input-object-file
outputs:
  - id: output_object_file
    type: File
    doc: File name in which to store serialized R object of type 
      'SingleCellExperiment'.
    outputBinding:
      glob: $(inputs.output_object_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
