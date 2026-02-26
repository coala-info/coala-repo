cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/sc3-sc3-estimate-k.R
label: sc3-scripts_sc3-sc3-estimate-k.R
doc: "Estimate the number of clusters (k) for SC3.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts"
inputs:
  - id: input_object_file
    type:
      - 'null'
      - File
    doc: File name in which a processed SC3 object can be found.
    inputBinding:
      position: 101
      prefix: --input-object-file
outputs:
  - id: output_object_file
    type:
      - 'null'
      - File
    doc: File name in which to store the SingleCellExperiment object with 
      estimated k'.
    outputBinding:
      glob: $(inputs.output_object_file)
  - id: output_text_file
    type:
      - 'null'
      - File
    doc: Text file name in which to store the estimated k'.
    outputBinding:
      glob: $(inputs.output_text_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
