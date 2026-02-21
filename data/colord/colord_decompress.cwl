cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - /usr/local/bin/colord
  - decompress
label: colord_decompress
doc: "decompression mode\n\nTool homepage: https://github.com/refresh-bio/colord"
inputs:
  - id: input
    type: File
    doc: archive path
    inputBinding:
      position: 1
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: optional reference genome path (multi-FASTA gzipped or not), required for
      reference-based archives with no reference genome embedded (`-G` compression
      without `-s` switch)
    inputBinding:
      position: 102
      prefix: --reference-genome
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: output file path
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colord:1.1.0--h9ee0642_0
