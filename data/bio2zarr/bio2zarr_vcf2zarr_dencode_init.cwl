cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2zarr
  - dencode-init
label: bio2zarr_vcf2zarr_dencode_init
doc: "Initialise conversion of intermediate format to VCF Zarr. This will set up the specified ZARR_PATH to perform this conversion over some number of partitions. The output of this commmand is the actual number of partitions generated and a rough lower-bound on the amount of memory required to encode a partition.\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: icf
    type: Directory
    doc: 'Finalised ICF directory; staged in the working directory and passed by name, so later dencode steps can find it again'
    inputBinding:
      position: 10
      valueFrom: $(self.basename)
  - id: zarr_path
    type: string
    doc: 'Output VCF Zarr directory'
    default: output.vcz
    inputBinding:
      position: 11
  - id: num_partitions
    type:
      - 'null'
      - int
    doc: 'Target number of partitions to split into [x>=1]'
    inputBinding:
      position: 1
      prefix: --num-partitions
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force overwriting of existing directories'
    inputBinding:
      position: 1
      prefix: --force
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
  - id: json
    type:
      - 'null'
      - boolean
    doc: 'Output summary data in JSON format'
    inputBinding:
      position: 1
      prefix: --json
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
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity'
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: zarr
    type: Directory
    doc: 'Initialised VCF Zarr directory (pass to dencode-partition)'
    outputBinding:
      glob: $(inputs.zarr_path)
  - id: summary
    type: stdout
    doc: Number of partitions and memory estimate
stdout: dencode_init_summary.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.icf)
        writable: false
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
