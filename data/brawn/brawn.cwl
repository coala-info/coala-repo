cwlVersion: v1.2
class: CommandLineTool
baseCommand: brawn
label: brawn
doc: "\nTool homepage: https://github.com/SJShaw/brawn"
inputs:
  - id: fasta
    type: File
    inputBinding:
      position: 1
  - id: build_cache
    type:
      - 'null'
      - string
    doc: Build a cache file of the input alignment (FASTA) at CACHE_PATH instead
      of aligning
    inputBinding:
      position: 102
      prefix: --build-cache
  - id: output_columns
    type:
      - 'null'
      - int
    doc: Line width of the FASTA output (default 60)
    inputBinding:
      position: 102
      prefix: --output-columns
  - id: reference_alignment
    type:
      - 'null'
      - File
    doc: Reference alignment (FASTA) or a cache file built with --build-cache
    inputBinding:
      position: 102
      prefix: --reference-alignment
outputs:
  - id: cache_file
    type:
      - 'null'
      - File
    doc: Cache file written with --build-cache
    outputBinding:
      glob: $(inputs.build_cache)
  - id: stdout
    type: stdout
    doc: Standard output (combined alignment in FASTA format)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/brawn:1.0.2--pyhdfd78af_0
stdout: brawn.out
