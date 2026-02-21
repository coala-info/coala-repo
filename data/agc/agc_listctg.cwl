cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agc
  - listctg
label: agc_listctg
doc: "List contigs in an AGC (Assembled Genomes Compressor) file for specified samples.\n
  \nTool homepage: https://github.com/refresh-bio/agc"
inputs:
  - id: input_agc
    type: File
    doc: Input AGC (Assembled Genomes Compressor) file
    inputBinding:
      position: 1
  - id: samples
    type:
      type: array
      items: string
    doc: Sample names to list contigs for
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'output to file (default: output is sent to stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agc:3.2.1--h9ee0642_0
