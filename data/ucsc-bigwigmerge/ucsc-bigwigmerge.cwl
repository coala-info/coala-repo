cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigMerge
label: ucsc-bigwigmerge
doc: "Merge together multiple bigWig files into a bedGraph.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input bigWig files to be merged
    inputBinding:
      position: 1
  - id: adjust
    type:
      - 'null'
      - float
    doc: Multiply all values by this factor
    default: 1.0
    inputBinding:
      position: 102
      prefix: -adjust
  - id: max_output
    type:
      - 'null'
      - boolean
    doc: Output the maximum value instead of the sum
    inputBinding:
      position: 102
      prefix: -maxOutput
  - id: threshold
    type:
      - 'null'
      - float
    doc: Only output values above this threshold
    default: 0.0
    inputBinding:
      position: 102
      prefix: -threshold
outputs:
  - id: output_file
    type: File
    doc: Output bedGraph file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigmerge:482--h0b57e2e_0
