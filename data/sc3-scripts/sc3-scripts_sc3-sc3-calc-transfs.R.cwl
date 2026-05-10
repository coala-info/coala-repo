cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/sc3-sc3-calc-transfs.R
label: sc3-scripts_sc3-sc3-calc-transfs.R
doc: "Calculates transformations for SC3.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts"
inputs:
  - id: input_object_file
    type: File
    doc: File name in which a processed SC3 'SingleCellExperiment' object has 
      been stored
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: output_object_file_path
    type: string
    doc: Output or path parameter `output_object_file_path`
    inputBinding:
      position: 102
      prefix: --output-object-file
outputs:
  - id: output_object_file
    type: File
    doc: File name in which to store a transformed R object of type 
      'SingleCellExperiment' from SC3.
    outputBinding:
      glob: $(inputs.output_object_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
