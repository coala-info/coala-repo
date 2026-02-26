cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mockinbird
  - flip_mate
label: mockinbird_flip_mate
doc: "flip the strand of the second read. Used for generating a normalizing pileup
  from a paired-end sequenced library\n\nTool homepage: https://github.com/soedinglab/mockinbird"
inputs:
  - id: input_bam
    type: File
    doc: path to paired-end bam file
    inputBinding:
      position: 1
outputs:
  - id: output_bam
    type: File
    doc: path to output bam file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mockinbird:1.0.0a1--py38he5da3d1_7
