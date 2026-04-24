cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msisensor-rna
  - show
label: msisensor-rna_show
doc: "Show the information of the model and add more details.\n\nTool homepage: https://github.com/xjtu-omics/msisensor-rna"
inputs:
  - id: cancer_type
    type:
      - 'null'
      - string
    doc: Rename the cancer type. e.g. CRC, STAD, PanCancer etc.
    inputBinding:
      position: 101
      prefix: --cancer_type
  - id: gene_list
    type:
      - 'null'
      - File
    doc: The path for the genes must be included for this model.
    inputBinding:
      position: 101
      prefix: --gene_list
  - id: input_description
    type:
      - 'null'
      - string
    doc: Add description for the input file.
    inputBinding:
      position: 101
      prefix: --input_description
  - id: model
    type: string
    doc: The trained model path.
    inputBinding:
      position: 101
      prefix: --model
  - id: model_description
    type:
      - 'null'
      - string
    doc: Add description for this trained model.
    inputBinding:
      position: 101
      prefix: --model_description
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor-rna:0.1.6--pyhdfd78af_0
stdout: msisensor-rna_show.out
