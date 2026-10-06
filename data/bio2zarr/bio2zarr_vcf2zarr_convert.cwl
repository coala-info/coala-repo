cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2zarr
  - convert
label: bio2zarr_vcf2zarr_convert
doc: "Convert input VCF(s) directly to VCF Zarr (not recommended for large files).\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
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
  - id: local_alleles
    type:
      - 'null'
      - boolean
    doc: 'Use local allele fields to reduce the storage requirements of the output. [default: no-local-alleles]'
    inputBinding:
      position: 1
      prefix: --local-alleles
  - id: no_local_alleles
    type:
      - 'null'
      - boolean
    doc: 'Do not use local allele fields (default)'
    inputBinding:
      position: 1
      prefix: --no-local-alleles
outputs:
  - id: zarr
    type: Directory
    doc: 'Output VCF Zarr store'
    outputBinding:
      glob: $(inputs.zarr_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
