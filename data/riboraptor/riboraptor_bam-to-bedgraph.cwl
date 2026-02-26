cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - riboraptor
  - bam-to-bedgraph
label: riboraptor_bam-to-bedgraph
doc: "Convert bam to bedgraph\n\nTool homepage: https://github.com/saketkc/riboraptor"
inputs:
  - id: bam_file
    type: File
    doc: Path to BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: end_type
    type:
      - 'null'
      - string
    doc: Pileup 5' / 3'/ either ends
    inputBinding:
      position: 101
      prefix: --end_type
  - id: strand
    type:
      - 'null'
      - string
    doc: Count from strand of this type only
    inputBinding:
      position: 101
      prefix: --strand
outputs:
  - id: saveto
    type:
      - 'null'
      - File
    doc: Path to write bedgraph output
    outputBinding:
      glob: $(inputs.saveto)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
