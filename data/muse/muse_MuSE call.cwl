cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MuSE
  - call
label: muse_MuSE call
doc: "Call somatic mutations using MuSE\n\nTool homepage: http://bioinformatics.mdanderson.org/main/MuSE"
inputs:
  - id: tumor_bam
    type: File
    doc: tumor.bam
    inputBinding:
      position: 1
  - id: matched_normal_bam
    type: File
    doc: matched_normal.bam
    inputBinding:
      position: 2
  - id: num_cores
    type:
      - 'null'
      - int
    doc: number of cores specified
    default: 1
    inputBinding:
      position: 103
      prefix: -n
  - id: reference_file
    type:
      - 'null'
      - File
    doc: faidx indexed reference sequence file
    inputBinding:
      position: 103
      prefix: -f
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name (suffix '.MuSE.txt' is automatically added)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muse:2.1.2--h3b3e331_3
