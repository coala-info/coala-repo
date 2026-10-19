cwlVersion: v1.2
class: CommandLineTool
baseCommand: renano
label: renano
doc: "Renano v1.0 Author Guillermo Dufort y Alvarez, 2020-2021\n\nTool homepage: https://github.com/guilledufort/RENANO"
inputs:
  - id: input_file
    type: File
    doc: Input file (FASTQ to compress, or compressed file with -d)
    inputBinding:
      position: 4
  - id: output_file
    type: string
    doc: Output file name (compressed file, or FASTQ with -d)
    inputBinding:
      position: 5
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Reference file for compression or decompression (-r ref_file)
    inputBinding:
      position: 2
      prefix: -r
  - id: reference_independent_file
    type:
      - 'null'
      - File
    doc: Reference file; makes decompression independent of the reference (-s
      ref_file)
    inputBinding:
      position: 2
      prefix: -s
  - id: paf_file
    type:
      - 'null'
      - File
    doc: PAF alignment file (used with a reference, compression only)
    inputBinding:
      position: 3
  - id: context_length
    type:
      - 'null'
      - int
    doc: Base call sequence context length. Default is 7 (max 13).
    inputBinding:
      position: 1
      prefix: -k
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: Flag to indicate decompression mode
    inputBinding:
      position: 1
      prefix: -d
  - id: neighborhood_length
    type:
      - 'null'
      - int
    doc: Length of the DNA neighborhood sequence. Default is 6.
    inputBinding:
      position: 1
      prefix: -l
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads allowed to use by the 
      compressor/decompressor. Default is 8.
    inputBinding:
      position: 1
      prefix: -t
outputs:
  - id: output
    type: File
    doc: Output file (compressed or decompressed)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/renano:1.3--h077b44d_4
