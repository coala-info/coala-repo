cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/scmap-preprocess-sce.R
label: scmap-cli_scmap-preprocess-sce.R
doc: "Preprocesses a SingleCellExperiment object for scmap.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scmap-cli"
inputs:
  - id: input_object
    type: File
    doc: Path to an SCE object in .rds format
    inputBinding:
      position: 101
      prefix: --input-object
outputs:
  - id: output_sce_object
    type: File
    doc: Path for the output object in .rds format
    outputBinding:
      glob: $(inputs.output_sce_object)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
