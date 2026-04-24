cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cramtools
  - getref
label: cramtools_getref
doc: "A list of MD5 checksums for which the sequences should be downloaded.\n\nTool
  homepage: https://github.com/enasequence/cramtools"
inputs:
  - id: fasta_line_length
    type:
      - 'null'
      - int
    doc: Wrap fasta lines accroding to this value.
    inputBinding:
      position: 101
      prefix: --fasta-line-length
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Compress fasta with gzip.
    inputBinding:
      position: 101
      prefix: --gzip
  - id: ignore_not_found
    type:
      - 'null'
      - boolean
    doc: Don't fail on not found sequences, just issue a warning.
    inputBinding:
      position: 101
      prefix: --ignore-not-found
  - id: input_file
    type:
      - 'null'
      - File
    doc: The path to the CRAM or BAM file to extract sequence MD5 checksums.
    inputBinding:
      position: 101
      prefix: --input-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Change log level: DEBUG, INFO, WARNING, ERROR.'
    inputBinding:
      position: 101
      prefix: --log-level
outputs:
  - id: destination_file
    type:
      - 'null'
      - File
    doc: Destination file.
    outputBinding:
      glob: $(inputs.destination_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cramtools:3.0.b127--0
