cwlVersion: v1.2
class: CommandLineTool
baseCommand: bgzip
label: htslib_bgzip
doc: Block compression/decompression utility
inputs:
  - id: input_file
    type: File
    doc: Input file to process
    inputBinding:
      position: 1
  - id: binary
    type:
      - 'null'
      - boolean
    doc: Don't align blocks with text lines
    inputBinding:
      position: 102
      prefix: --binary
  - id: compress_level
    type:
      - 'null'
      - int
    doc: Compression level to use when compressing; 0 to 9, or -1 for default
    inputBinding:
      position: 102
      prefix: --compress-level
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: decompress
    inputBinding:
      position: 102
      prefix: --decompress
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite files without asking
    inputBinding:
      position: 102
      prefix: --force
  - id: index
    type:
      - 'null'
      - boolean
    doc: compress and create BGZF index
    inputBinding:
      position: 102
      prefix: --index
  - id: index_name
    type:
      - 'null'
      - string
    doc: name of BGZF index file [file.gz.gzi] (path string; not a pre-existing staged input)
    inputBinding:
      position: 102
      prefix: --index-name
  - id: keep
    type:
      - 'null'
      - boolean
    doc: don't delete input files during operation
    inputBinding:
      position: 102
      prefix: --keep
  - id: offset
    type:
      - 'null'
      - int
    doc: decompress at virtual file pointer (0-based uncompressed offset)
    inputBinding:
      position: 102
      prefix: --offset
  - id: output
    type: string
    doc: write to file, keep original files unchanged
    inputBinding:
      position: 102
      prefix: --output
  - id: rebgzip
    type:
      - 'null'
      - boolean
    doc: use an index file to bgzip a file
    inputBinding:
      position: 102
      prefix: --rebgzip
  - id: reindex
    type:
      - 'null'
      - boolean
    doc: (re)index compressed file
    inputBinding:
      position: 102
      prefix: --reindex
  - id: size
    type:
      - 'null'
      - int
    doc: decompress INT bytes (uncompressed size)
    inputBinding:
      position: 102
      prefix: --size
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: write on standard output, keep original files unchanged
    inputBinding:
      position: 102
      prefix: --stdout
  - id: test
    type:
      - 'null'
      - boolean
    doc: test integrity of compressed file
    inputBinding:
      position: 102
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: number of compression threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: write to file, keep original files unchanged
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htslib:1.23--h566b1c6_0
s:url: https://github.com/samtools/htslib
$namespaces:
  s: https://schema.org/
