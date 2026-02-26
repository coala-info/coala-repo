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
outputs:
  - id: saveto
    type:
      - 'null'
      - File
    doc: Path to write read length dist tsv output
    outputBinding:
      glob: $(inputs.saveto)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
