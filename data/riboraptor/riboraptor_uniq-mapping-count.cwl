cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - riboraptor
  - uniq-mapping-count
label: riboraptor_uniq-mapping-count
doc: "Count number of unique mapping reads\n\nTool homepage: https://github.com/saketkc/riboraptor"
inputs:
  - id: bam
    type: File
    doc: Path to BAM file
    inputBinding:
      position: 101
      prefix: --bam
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
stdout: riboraptor_uniq-mapping-count.out
