cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rnftools
  - sam2roc
label: rnftools_sam2roc
doc: "todo\n\nTool homepage: http://karel-brinda.github.io/rnftools"
inputs:
  - id: allowed_delta
    type:
      - 'null'
      - int
    doc: Tolerance of difference of coordinates between true (i.e., expected) 
      alignment and real alignment (very important parameter!)
    inputBinding:
      position: 101
      prefix: --allowed-delta
  - id: sam_file
    type: File
    doc: SAM/BAM with aligned RNF reads(- for standard input).
    inputBinding:
      position: 101
      prefix: --sam
  - id: roc_file_path
    type: string
    doc: Output or path parameter `roc_file_path`
    inputBinding:
      position: 102
      prefix: --roc-file
outputs:
  - id: roc_file
    type: File
    doc: Output ROC file (- for standard output).
    outputBinding:
      glob: $(inputs.roc_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
