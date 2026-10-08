cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tskit2zarr
  - convert
label: bio2zarr_tskit2zarr_convert
doc: "Convert a tskit tree sequence to VCF Zarr format.\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: ts_path
    type: File
    doc: 'Input tskit tree sequence file (.trees)'
    inputBinding:
      position: 10
  - id: zarr_path
    type: string
    doc: 'Output VCF Zarr directory'
    default: output.vcz
    inputBinding:
      position: 11
  - id: contig_id
    type:
      - 'null'
      - string
    doc: "Contig/chromosome ID (default: '1')"
    inputBinding:
      position: 1
      prefix: --contig-id
  - id: isolated_as_missing
    type:
      - 'null'
      - boolean
    doc: 'Treat isolated samples without mutations as missing (default: tskit default)'
    inputBinding:
      position: 1
      prefix: --isolated-as-missing
  - id: isolated_as_ancestral
    type:
      - 'null'
      - boolean
    doc: 'Treat isolated samples without mutations as ancestral (default: tskit default)'
    inputBinding:
      position: 1
      prefix: --isolated-as-ancestral
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
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity'
    inputBinding:
      position: 1
      prefix: --verbose
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
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force overwriting of existing directories'
    inputBinding:
      position: 1
      prefix: --force
outputs:
  - id: zarr
    type: Directory
    doc: 'Output VCF Zarr store'
    outputBinding:
      glob: $(inputs.zarr_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
