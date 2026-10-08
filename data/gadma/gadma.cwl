cwlVersion: v1.2
class: CommandLineTool
baseCommand: gadma
label: gadma
doc: "GADMA is a tool for demographic inference.\n\nTool homepage: https://github.com/ctlab/GADMA"
inputs:
  - id: extra_params_file
    type:
      - 'null'
      - File
    doc: Extra parameters file
    inputBinding:
      position: 101
      prefix: --extra
  - id: input_data
    type:
      - 'null'
      - type: array
        items: File
    doc: input data for demographic inference (AFS or dadi format file, or a VCF file followed by
      its popmap file).
    inputBinding:
      position: 101
      prefix: --input
      itemSeparator: ','
  - id: only_models
    type:
      - 'null'
      - boolean
    doc: flag to take models only from another launch (--resume option).
    inputBinding:
      position: 101
      prefix: --only_models
  - id: params_file
    type:
      - 'null'
      - File
    doc: Parameters file
    inputBinding:
      position: 101
      prefix: --params
  - id: resume_dir
    type:
      - 'null'
      - Directory
    doc: resume another launch from <resume_dir>.
    inputBinding:
      position: 101
      prefix: --resume
  - id: test
    type:
      - 'null'
      - boolean
    doc: run test case.
    inputBinding:
      position: 101
      prefix: --test
  - id: output_dir_path
    type: string
    doc: "<output_dir>\t\toutput directory."
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory.
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gadma:2.0.3--pyhdfd78af_0
