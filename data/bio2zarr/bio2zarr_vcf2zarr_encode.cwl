cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2zarr
  - encode
label: bio2zarr_vcf2zarr_encode
doc: "Convert intermediate columnar format to VCF Zarr.\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: icf
    type: Directory
    doc: Intermediate columnar format (ICF) directory made by explode
    inputBinding:
      position: 10
  - id: zarr_path
    type: string
    doc: 'Output VCF Zarr directory'
    default: output.vcz
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
  - id: schema
    type:
      - 'null'
      - File
    doc: 'Schema file (JSON) made by vcf2zarr mkschema'
    inputBinding:
      position: 1
      prefix: --schema
  - id: variants_chunk_size
    type:
      - 'null'
      - int
    doc: 'Chunk size in the variants dimension'
    inputBinding:
      position: 1
      prefix: --variants-chunk-size
  - id: samples_chunk_size
    type:
      - 'null'
      - int
    doc: 'Chunk size in the samples dimension'
    inputBinding:
      position: 1
      prefix: --samples-chunk-size
  - id: max_variant_chunks
    type:
      - 'null'
      - int
    doc: 'Truncate the output in the variants dimension to have this number of chunks. Mainly intended to help with schema tuning.'
    inputBinding:
      position: 1
      prefix: --max-variant-chunks
  - id: max_memory
    type:
      - 'null'
      - string
    doc: 'An approximate bound on overall memory usage (e.g. 10G),'
    inputBinding:
      position: 1
      prefix: --max-memory
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
  - id: zarr
    type: Directory
    doc: 'Output VCF Zarr store'
    outputBinding:
      glob: $(inputs.zarr_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
