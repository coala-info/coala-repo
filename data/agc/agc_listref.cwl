cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agc
  - listref
label: agc_listref
doc: "List reference genomes in an AGC (Assembled Genomes Compressor) file\n\nTool
  homepage: https://github.com/refresh-bio/agc"
inputs:
  - id: input_agc
    type: File
    doc: Input AGC file
    inputBinding:
      position: 1
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
