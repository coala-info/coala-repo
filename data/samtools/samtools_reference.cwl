cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - reference
label: samtools_reference
doc: "Extract the reference sequence from a CRAM file\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input CRAM file
    inputBinding:
      position: 1
  - id: e_flag
    type:
      - 'null'
      - boolean
    doc: Enable specific reference extraction option (-e)
    inputBinding:
      position: 102
      prefix: -e
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode
    inputBinding:
      position: 102
      prefix: -q
  - id: region
    type:
      - 'null'
      - string
    doc: Region to extract
    inputBinding:
      position: 102
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: -@
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name (e.g., out.fa)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
