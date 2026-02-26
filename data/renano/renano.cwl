cwlVersion: v1.2
class: CommandLineTool
baseCommand: renano
label: renano
doc: "Renano v1.0 Author Guillermo Dufort y Alvarez, 2020-2021\n\nTool homepage: https://github.com/guilledufort/RENANO"
inputs:
  - id: paf_file
    type:
      - 'null'
      - File
    doc: PAF file (used with reference)
    inputBinding:
      position: 1
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file (compressed or decompressed)
    inputBinding:
      position: 2
  - id: context_length
    type:
      - 'null'
      - int
    doc: Base call sequence context length. Default is 7 (max 13).
    default: 7
    inputBinding:
      position: 103
      prefix: -k
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: Flag to indicate decompression mode
    inputBinding:
      position: 103
      prefix: -d
  - id: neighborhood_length
    type:
      - 'null'
      - int
    doc: Length of the DNA neighborhood sequence. Default is 6.
    default: 6
    inputBinding:
      position: 103
      prefix: -l
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Reference file for compression or decompression
    inputBinding:
      position: 103
      prefix: -r
  - id: reference_independent_compression
    type:
      - 'null'
      - boolean
    doc: Flag to make compression independent of the reference
    inputBinding:
      position: 103
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads allowed to use by the 
      compressor/decompressor. Default is 8.
    default: 8
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file (compressed or decompressed)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/renano:1.3--h077b44d_4
