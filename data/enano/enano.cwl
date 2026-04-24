cwlVersion: v1.2
class: CommandLineTool
baseCommand: enano
label: enano
doc: "Compresses and decompresses FASTQ files using methods from FQZComp and a range
  coder derived from Eugene Shelwien.\n\nTool homepage: https://github.com/guilledufort/EnanoFASTQ"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file for compression or decompression.
    inputBinding:
      position: 1
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for compression or decompression.
    inputBinding:
      position: 2
  - id: context_length_dna
    type:
      - 'null'
      - int
    doc: Length of the DNA sequence context. Default is 6.
    inputBinding:
      position: 103
      prefix: -l
  - id: context_length_seq
    type:
      - 'null'
      - int
    doc: Base sequence context length. Default is 7 (max 13).
    inputBinding:
      position: 103
      prefix: -k
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: Decompress mode.
    inputBinding:
      position: 103
      prefix: -d
  - id: mode
    type:
      - 'null'
      - boolean
    doc: To use MAX COMPRESION MODE. Default is FAST MODE.
    inputBinding:
      position: 103
      prefix: --max_compression
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads allowed to use by the compressor.
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enano:1.0--h077b44d_7
stdout: enano.out
