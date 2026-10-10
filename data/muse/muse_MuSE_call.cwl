cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MuSE
  - call
label: muse_MuSE_call
doc: "Call somatic mutations using MuSE. Usage: MuSE call [options] tumor.bam matched_normal.bam\n\nTool
  homepage: http://bioinformatics.mdanderson.org/main/MuSE"
inputs:
  - id: reference_file
    type: File
    doc: faidx indexed reference sequence file
    secondaryFiles:
      - .fai
    inputBinding:
      position: 1
      prefix: -f
  - id: output_prefix
    type: string
    doc: output file name (suffix '.MuSE.txt' is automatically added)
    inputBinding:
      position: 2
      prefix: -O
  - id: num_cores
    type:
      - 'null'
      - int
    doc: number of cores specified
    inputBinding:
      position: 3
      prefix: -n
  - id: tumor_bam
    type: File
    doc: tumor.bam
    secondaryFiles:
      - .bai
    inputBinding:
      position: 4
  - id: matched_normal_bam
    type: File
    doc: matched_normal.bam
    secondaryFiles:
      - .bai
    inputBinding:
      position: 5
outputs:
  - id: output_file
    type: File
    doc: MuSE call result (<output_prefix>.MuSE.txt)
    outputBinding:
      glob: $(inputs.output_prefix).MuSE.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muse:2.1.2--h3b3e331_3
