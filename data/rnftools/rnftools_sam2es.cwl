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
    default: 5
    inputBinding:
      position: 101
      prefix: --allowed-delta
  - id: sam_file
    type: File
    doc: SAM/BAM with aligned RNF reads(- for standard input).
    inputBinding:
      position: 101
      prefix: --sam
outputs:
  - id: output_es_file
    type: File
    doc: Output ES file (evaluated segments, - for standard output).
    outputBinding:
      glob: $(inputs.output_es_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
