cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rnftools
  - sam2es
label: rnftools_sam2es
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
  - id: output_es_file_path
    type: string
    doc: Output or path parameter `output_es_file_path`
    inputBinding:
      position: 102
      prefix: --output-es-file
outputs:
  - id: output_es_file
    type: File
    doc: Output ES file (evaluated segments, - for standard output).
    outputBinding:
      glob: $(inputs.output_es_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
