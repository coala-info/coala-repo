cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - sam
  - assign-mi
label: djinn_sam_assign_mi
doc: "Assign an MI:i (Molecular Identifier) tags\n\nTool homepage: https://github.com/pdimens/djinn"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: cutoff
    type:
      - 'null'
      - int
    doc: Distance in base pairs at which alignments with the same barcode should be
      considered different molecules. If 0, then alignment distance is ignored.
    inputBinding:
      position: 1
      prefix: --cutoff
  - id: keep_unmapped
    type:
      - 'null'
      - boolean
    doc: Keep unmapped records
    inputBinding:
      position: 1
      prefix: --keep-unmapped
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
    doc: Input SAM/BAM file in standard format (BX and VX tags), coordinate sorted
    inputBinding:
      position: 101
outputs:
  - id: output_alignments
    type: stdout
    doc: Alignments with MI:i tags
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
stdout: '$(inputs.sam ? ''djinn_sam_assign_mi.sam'' : ''djinn_sam_assign_mi.bam'')'
