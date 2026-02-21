cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - cram_size
label: samtools_cram_size
doc: "Calculate the size of CRAM files\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_cram
    type:
      - 'null'
      - File
    doc: Input CRAM file
    inputBinding:
      position: 1
  - id: extended
    type:
      - 'null'
      - boolean
    doc: Extended output
    inputBinding:
      position: 102
      prefix: -e
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
