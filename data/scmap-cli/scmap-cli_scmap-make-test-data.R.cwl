cwlVersion: v1.2
class: CommandLineTool
baseCommand: scmap-make-test-data.R
label: scmap-cli_scmap-make-test-data.R
doc: "Creates a test SingleCellExperiment object from the example dataset of the scmap R package.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scmap-cli"
inputs:
  - id: output_object_file_path
    type: string
    doc: file name in which to store serialized R object of type 'SingleCellExperiment'.
    inputBinding:
      position: 101
      prefix: --output-object-file
outputs:
  - id: output_object_file
    type: File
    doc: Serialized SingleCellExperiment object
    outputBinding:
      glob: $(inputs.output_object_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
