cwlVersion: v1.2
class: CommandLineTool
baseCommand: imfusion-expression
label: imfusion_expression
doc: "imfusion-expression: error: the following arguments are required: --sample_dir,
  --reference\n\nTool homepage: https://github.com/iamsh4shank/Imfusion"
inputs:
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Paired-end sequencing
    inputBinding:
      position: 101
      prefix: --paired
  - id: reference
    type: File
    doc: Reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: sample_dir
    type: Directory
    doc: Sample directory
    inputBinding:
      position: 101
      prefix: --sample_dir
  - id: stranded
    type:
      - 'null'
      - string
    doc: Strand specificity of the RNA-Seq library
    inputBinding:
      position: 101
      prefix: --stranded
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
