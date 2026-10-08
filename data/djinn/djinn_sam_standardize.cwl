cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - sam
  - standardize
label: djinn_sam_standardize
doc: "Move barcodes to BX+VX sequence header tags\n\nTool homepage: https://github.com/pdimens/djinn"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
inputs:
  - id: style
    type:
      - 'null'
      - type: enum
        symbols:
          - haplotagging
          - stlfr
          - tellseq
          - 10x
    doc: Change the barcode style
    inputBinding:
      position: 1
      prefix: --style
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
    doc: Alignments with barcodes in BX:Z and VX:i tags
  - id: barcode_map
    type: File?
    doc: Barcode conversion map (<input>.bc), with --style
    outputBinding:
      glob: $(inputs.input.basename).bc
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
stdout: '$(inputs.sam ? ''djinn_sam_standardize.sam'' : ''djinn_sam_standardize.bam'')'
