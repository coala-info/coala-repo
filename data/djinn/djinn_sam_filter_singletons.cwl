cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - sam
  - filter-singletons
label: djinn_sam_filter_singletons
doc: "Retain only non-singleton reads\n\nTool homepage: https://github.com/pdimens/djinn"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: singletons
    type:
      - 'null'
      - string
    doc: Print valid singleton records to this file
    inputBinding:
      position: 1
      prefix: --singletons
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Output as SAM instead of BAM
    inputBinding:
      position: 1
      prefix: --sam
  - id: input
    type: File
    doc: Input SAM/BAM file
    inputBinding:
      position: 101
outputs:
  - id: output_alignments
    type: stdout
    doc: Records with valid non-singleton barcodes
  - id: singleton_records
    type: File?
    doc: Records with valid singleton barcodes, with --singletons
    outputBinding:
      glob: '$(inputs.singletons ? inputs.singletons : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
stdout: '$(inputs.sam ? ''djinn_sam_filter_singletons.sam'' : ''djinn_sam_filter_singletons.bam'')'
