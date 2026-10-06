cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2zarr
  - dexplode-init
label: bio2zarr_vcf2zarr_dexplode_init
doc: "Initial step for distributed conversion of VCF(s) to intermediate columnar format over some number of paritions.\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: vcfs
    type:
      type: array
      items: File
    doc: Input VCF/BCF file(s), bgzipped and indexed (.tbi or .csi). Staged in 
      the working directory and passed by name, so later partition steps can 
      find them again.
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
    inputBinding:
      position: 10
      valueFrom: $(self.map(function(f){return f.basename}))
  - id: icf_path
    type: string
    doc: 'Output intermediate columnar format (ICF) directory'
    default: output.icf
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
  - id: json
    type:
      - 'null'
      - boolean
    doc: 'Output summary data in JSON format'
    inputBinding:
      position: 1
      prefix: --json
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
outputs:
  - id: icf
    type: Directory
    doc: 'Initialised ICF directory (pass to dexplode-partition)'
    outputBinding:
      glob: $(inputs.icf_path)
  - id: summary
    type: stdout
    doc: Summary with the number of partitions
stdout: dexplode_init_summary.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.vcfs)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
