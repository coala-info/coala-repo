cwlVersion: v1.2
class: CommandLineTool
baseCommand: mark_intron_retention
label: flair_mark_intron_retention
doc: 'Mark intron retention events in an isoform bed file.


  Tool homepage: https://github.com/BrooksLabUCSC/flair'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: in_bed
    type: File
    doc: Input isoform bed file
    inputBinding:
      position: 1
  - id: out_isoforms_bed
    type: string
    doc: Output isoform bed file
    inputBinding:
      position: 2
  - id: out_introns_txt
    type: string
    doc: Output introns text file
    inputBinding:
      position: 3
outputs:
  - id: isoforms_bed
    type: File
    doc: Output isoform bed file
    outputBinding:
      glob: $(inputs.out_isoforms_bed)
  - id: introns_txt
    type: File
    doc: Output introns file
    outputBinding:
      glob: $(inputs.out_introns_txt)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
