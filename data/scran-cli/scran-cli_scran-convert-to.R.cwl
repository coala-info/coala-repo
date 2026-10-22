cwlVersion: v1.2
class: CommandLineTool
baseCommand: scran-convert-to.R
label: scran-cli_scran-convert-to.R
doc: "Convert a SingleCellExperiment object to an edgeR, DESeq2 or monocle object.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scran-cli"
inputs:
  - id: input_sce_object
    type: File
    doc: "Path to the input SCE object in rds format."
    inputBinding:
      prefix: --input-sce-object
  - id: type
    type: ['null', string]
    doc: "A string specifying the analysis for which the object should be prepared. Any of: edgeR, DESeq2, monocle."
    inputBinding:
      prefix: --type
  - id: assay_type
    type: ['null', string]
    doc: "A string specifying which assay of x should be put in the returned object. For edgeR and DESeq2, assay is set to counts such that count data is stored in the output object"
    inputBinding:
      prefix: --assay-type
  - id: get_spikes
    type: ['null', string]
    doc: "Logical specifying wether to perform spike-ins filtering(FALSE) or not (TRUE). (TRUE or FALSE)"
    inputBinding:
      prefix: --get-spikes
  - id: output_converted_path
    type: string
    doc: "Path to the converted object stored as RDS."
    inputBinding:
      prefix: --output-converted
outputs:
  - id: output_converted
    type: File
    doc: "Converted object stored as RDS"
    outputBinding:
      glob: $(inputs.output_converted_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
