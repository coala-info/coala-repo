cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/scater-extract-qc-metric.R
label: scater-scripts_scater-extract-qc-metric.R
doc: "Extracts a specified quality control metric from a singleCellExperiment object
  and saves it to a file.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts"
inputs:
  - id: input_object_file
    type: File
    doc: singleCellExperiment object containing expression values and 
      experimental information. Must have been appropriately prepared.
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: metric
    type: string
    doc: Metric name.
    inputBinding:
      position: 101
      prefix: --metric
outputs:
  - id: output_file
    type: File
    doc: Output file name, will be comma-separated cell,value.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scater-scripts:0.0.5--0
