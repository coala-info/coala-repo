cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - riboraptor
  - read-length-dist
label: riboraptor_read-length-dist
doc: "Calculate read length distribution\n\nTool homepage: https://github.com/saketkc/riboraptor"
inputs:
  - id: bam
    type: File
    doc: Path to BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: saveto_path
    type: string
    doc: Path to write bedgraph output
    inputBinding:
      position: 102
      prefix: --saveto
outputs:
  - id: saveto
    type:
      - 'null'
      - File
    doc: Path to write read length dist tsv output
    outputBinding:
      glob: $(inputs.saveto_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
