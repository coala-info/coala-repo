cwlVersion: v1.2
class: CommandLineTool
baseCommand: hictk fix-mcool
label: hictk_fix-mcool
doc: "Fix corrupted .mcool files.\n\nTool homepage: https://github.com/paulsengroup/hictk"
inputs:
  - id: input
    type: File
    doc: Path to a corrupted .mcool file.
    inputBinding:
      position: 1
  - id: check_base_resolution
    type:
      - 'null'
      - boolean
    doc: Check whether the base resolution is corrupted.
    inputBinding:
      position: 102
      prefix: --check-base-resolution
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Number of interactions to process at once during balancing. Ignored 
      when using --in-memory.
    default: 10000000
    inputBinding:
      position: 102
      prefix: --chunk-size
  - id: compression_lvl
    type:
      - 'null'
      - int
    doc: Compression level used to compress temporary files using ZSTD (only 
      applies to the balancing stage).
    default: 3
    inputBinding:
      position: 102
      prefix: --compression-lvl
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files (if any).
    inputBinding:
      position: 102
      prefix: --force
  - id: in_memory
    type:
      - 'null'
      - boolean
    doc: Store all interactions in memory while balancing (greatly improves 
      performance).
    inputBinding:
      position: 102
      prefix: --in-memory
  - id: skip_balancing
    type:
      - 'null'
      - boolean
    doc: Do not recompute or copy balancing weights.
    inputBinding:
      position: 102
      prefix: --skip-balancing
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of parallel threads to spawn (only applies to the 
      balancing stage).
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Path to a folder where to store temporary data.
    inputBinding:
      position: 102
      prefix: --tmpdir
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set verbosity of output to the console.
    default: 3
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output
    type: File
    doc: Path where to store the restored .mcool.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
