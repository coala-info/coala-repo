cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2zarr
  - explode
label: bio2zarr_vcf2zarr_explode
doc: "Convert VCF(s) to intermediate columnar format\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: vcfs
    type:
      type: array
      items: File
    doc: Input VCF/BCF file(s), bgzipped and indexed (.tbi or .csi).
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
    inputBinding:
      position: 10
  - id: icf_path
    type: string
    doc: 'Output intermediate columnar format (ICF) directory'
    default: output.icf
    inputBinding:
      position: 11
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force overwriting of existing directories'
    inputBinding:
      position: 1
      prefix: --force
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity'
    inputBinding:
      position: 1
      prefix: --verbose
  - id: column_chunk_size
    type:
      - 'null'
      - int
    doc: 'Approximate uncompressed size of exploded column chunks in MiB'
    inputBinding:
      position: 1
      prefix: --column-chunk-size
  - id: compressor
    type:
      - 'null'
      - string
    doc: 'Codec to use for compressing column chunks: lz4 or zstd (Default=zstd).'
    inputBinding:
      position: 1
      prefix: --compressor
  - id: progress
    type:
      - 'null'
      - boolean
    doc: 'Show progress bars (default: show)'
    inputBinding:
      position: 1
      prefix: --progress
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: 'Do not show progress bars'
    inputBinding:
      position: 1
      prefix: --no-progress
  - id: worker_processes
    type:
      - 'null'
      - int
    doc: 'Number of worker processes  [default: 0]'
    inputBinding:
      position: 1
      prefix: --worker-processes
outputs:
  - id: icf
    type: Directory
    doc: 'Intermediate columnar format directory'
    outputBinding:
      glob: $(inputs.icf_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
