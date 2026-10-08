cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - sam
  - concat
label: djinn_sam_concat
doc: "Molecule-aware file concatenation\n\nTool homepage: https://github.com/pdimens/djinn"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: mi
    type:
      - 'null'
      - type: enum
        symbols:
          - haplotagging
          - stlfr
          - tellseq
    doc: MI tag is the primary molecule identifier and write new barcodes in this
      format
    inputBinding:
      position: 1
      prefix: --mi
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Output as SAM instead of BAM
    inputBinding:
      position: 1
      prefix: --sam
  - id: input
    type:
      type: array
      items: File
    doc: Input SAM/BAM files
    inputBinding:
      position: 101
outputs:
  - id: output_alignments
    type: stdout
    doc: Concatenated alignments
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
stdout: '$(inputs.sam ? ''djinn_sam_concat.sam'' : ''djinn_sam_concat.bam'')'
