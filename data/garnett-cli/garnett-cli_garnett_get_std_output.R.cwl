cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/garnett_get_std_output.R
label: garnett-cli_garnett_get_std_output.R
doc: "Get standard output from a CDS object\n\nTool homepage: https://github.com/ebi-gene-expression-group/garnett-cli"
inputs:
  - id: cell_id_field
    type:
      - 'null'
      - string
    doc: Column name of the cell id annotations. If not supplied, it is assumed 
      that cell ids are represented by index
    inputBinding:
      position: 101
      prefix: --cell-id-field
  - id: classifier
    type:
      - 'null'
      - File
    doc: Path to the classifier object in .rds format (Optional; required to add
      dataset of origin to output table)
    inputBinding:
      position: 101
      prefix: --classifier
  - id: input_object
    type: File
    doc: Path to the input CDS object in .rds format
    inputBinding:
      position: 101
      prefix: --input-object
  - id: predicted_cell_type_field
    type:
      - 'null'
      - string
    doc: Column name of the predicted cell type annotation
    inputBinding:
      position: 101
      prefix: --predicted-cell-type-field
outputs:
  - id: output_file_path
    type: File
    doc: Path to the produced output file in .tsv format
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
