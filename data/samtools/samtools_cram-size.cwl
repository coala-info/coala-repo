cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- cram-size
label: samtools_cram-size
doc: 'List CRAM Content-ID and Data-Series sizes


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_cram
  type:
  - 'null'
  - File
  doc: Input CRAM file.
  inputBinding:
    position: 104
- id: extended
  type:
  - 'null'
  - boolean
  doc: Extended output (-e).
  inputBinding:
    position: 103
    prefix: -e
- id: verbose
  type:
  - 'null'
  - boolean
  doc: Verbose output (-v).
  inputBinding:
    position: 103
    prefix: -v
- id: output_filename
  type: string
  doc: Output file (-o).
  default: cram_size.txt
  inputBinding:
    position: 103
    prefix: -o
outputs:
- id: output
  type: File
  doc: CRAM content-ID and data-series sizes.
  outputBinding:
    glob: $(inputs.output_filename)
