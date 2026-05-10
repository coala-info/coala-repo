cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnftools et2roc
label: rnftools_et2roc
doc: "todo\n\nTool homepage: http://karel-brinda.github.io/rnftools"
inputs:
  - id: input_et_file
    type: File
    doc: Input ET file (evaluated read tuples, - for standard input).
    inputBinding:
      position: 101
      prefix: --et
  - id: output_roc_file_path
    type: string
    doc: Output or path parameter `output_roc_file_path`
    inputBinding:
      position: 102
      prefix: --output-roc-file
outputs:
  - id: output_roc_file
    type: File
    doc: Output ROC file (evaluated reads, - for standard output).
    outputBinding:
      glob: $(inputs.output_roc_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
