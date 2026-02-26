cwlVersion: v1.2
class: CommandLineTool
baseCommand: neodisambiguate
label: neodisambiguate
doc: "Disambiguate reads that were mapped to multiple references.\n\nTool homepage:
  https://github.com/clintval/neodisambiguate"
inputs:
  - id: input_bams
    type:
      type: array
      items: File
    doc: The BAMs to disambiguate
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: The output file prefix (e.g. dir/sample_prefix)
    inputBinding:
      position: 2
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O for SAM and BAM files
    inputBinding:
      position: 103
      prefix: --async-io
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Default GZIP BAM compression level
    inputBinding:
      position: 103
      prefix: --compression
  - id: reference_names
    type:
      - 'null'
      - type: array
        items: string
    doc: The reference assembly names.
    default: first assembly in the BAM headers
    inputBinding:
      position: 103
      prefix: --names
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files
    inputBinding:
      position: 103
      prefix: --tmp-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neodisambiguate:1.1.1--hdfd78af_0
stdout: neodisambiguate.out
