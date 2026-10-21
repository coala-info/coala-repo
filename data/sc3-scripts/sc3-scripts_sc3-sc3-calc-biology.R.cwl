cwlVersion: v1.2
class: CommandLineTool
baseCommand: sc3-sc3-calc-biology.R
label: sc3-scripts_sc3-sc3-calc-biology.R
doc: "Calculates the biology of SC3 clusters (marker genes, differentially expressed genes or outlier cells) from a SingleCellExperiment object after k-means clustering and consensus.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts"
inputs:
  - id: input_object_file
    type: File
    doc: File name in which a SC3 'SingleCellExperiment' object has been stored
      after kmeans clustering.
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: ks
    type:
      - 'null'
      - string
    doc: A comma-separated string or single value representing the number of
      clusters k to be used for SC3 clustering.
    inputBinding:
      position: 101
      prefix: --ks
  - id: regime
    type:
      - 'null'
      - string
    doc: 'Defines what biological analysis to perform. "marker" for marker genes,
      "de" for differentially expressed genes and "outl" for outlier cells.'
    inputBinding:
      position: 101
      prefix: --regime
  - id: output_object_file_path
    type: string
    doc: File name for R object of type 'SingleCellExperiment' from SC3 in which
      to store the results.
    inputBinding:
      position: 102
      prefix: --output-object-file
  - id: output_text_file_path
    type:
      - 'null'
      - string
    doc: A text file to write marker matrices to. A 'k' column defines from
      which value of 'k' the markers are derived.
    inputBinding:
      position: 103
      prefix: --output-text-file
outputs:
  - id: output_object_file
    type: File
    doc: File name for R object of type 'SingleCellExperiment' from SC3.
    outputBinding:
      glob: $(inputs.output_object_file_path)
  - id: output_text_file
    type:
      - 'null'
      - File
    doc: Text file with the marker matrices.
    outputBinding:
      glob: $(inputs.output_text_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
