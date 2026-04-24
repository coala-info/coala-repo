cwlVersion: v1.2
class: CommandLineTool
baseCommand: hictk load
label: hictk_load
doc: "Build .cool and .hic files from interactions in various text formats.\n\nTool
  homepage: https://github.com/paulsengroup/hictk"
inputs:
  - id: interactions
    type: File
    doc: Path to a file with the interactions to be loaded. Common compression 
      formats are supported (namely, bzip2, gzip, lz4, lzo, xz, and zstd). Pass 
      "-" to indicate that interactions should be read from stdin.
    inputBinding:
      position: 1
  - id: assembly
    type:
      - 'null'
      - string
    doc: Assembly name.
    inputBinding:
      position: 102
      prefix: --assembly
  - id: assume_sorted
    type:
      - 'null'
      - boolean
    doc: Assume input files are already sorted.
    inputBinding:
      position: 102
      prefix: --assume-sorted
  - id: assume_unsorted
    type:
      - 'null'
      - boolean
    doc: Assume input files are already sorted.
    inputBinding:
      position: 102
      prefix: --assume-unsorted
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Bin size (bp). Required when --bin-table is not used.
    inputBinding:
      position: 102
      prefix: --bin-size
  - id: bin_table
    type:
      - 'null'
      - File
    doc: Path to a BED3+ file with the bin table.
    inputBinding:
      position: 102
      prefix: --bin-table
  - id: chrom_sizes
    type:
      - 'null'
      - File
    doc: Path to .chrom.sizes file. Required when interactions are not in 4DN 
      pairs format.
    inputBinding:
      position: 102
      prefix: --chrom-sizes
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Number of pixels to buffer in memory.
    inputBinding:
      position: 102
      prefix: --chunk-size
  - id: compression_lvl
    type:
      - 'null'
      - int
    doc: Compression level used to compress interactions. Defaults to 6 and 10 
      for .cool and .hic files, respectively.
    inputBinding:
      position: 102
      prefix: --compression-lvl
  - id: count_as_float
    type:
      - 'null'
      - boolean
    doc: Interactions are floats.
    inputBinding:
      position: 102
      prefix: --count-as-float
  - id: drop_unknown_chroms
    type:
      - 'null'
      - boolean
    doc: Ignore records referencing unknown chromosomes.
    inputBinding:
      position: 102
      prefix: --drop-unknown-chroms
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite existing output file(s).
    inputBinding:
      position: 102
      prefix: --force
  - id: input_format
    type: string
    doc: Input format.
    inputBinding:
      position: 102
      prefix: --format
  - id: no_skip_all_vs_all
    type:
      - 'null'
      - boolean
    doc: Do not generate All vs All matrix. Has no effect when creating .cool 
      files.
    inputBinding:
      position: 102
      prefix: --no-skip-all-vs-all
  - id: no_transpose_lower_triangular_pixels
    type:
      - 'null'
      - boolean
    doc: Transpose pixels overlapping the lower-triangular matrix. When 
      --no-transpose-lower-triangular-pixels is used and one or more pixels 
      overlapping with the lower triangular matrix are encountered an exception 
      will be raised.
    inputBinding:
      position: 102
      prefix: --no-transpose-lower-triangular-pixels
  - id: no_validate_pixels
    type:
      - 'null'
      - boolean
    doc: Toggle pixel validation on or off. When --no-validate-pixels is used 
      and invalid pixels are encountered, hictk will either crash or produce 
      invalid files.
    inputBinding:
      position: 102
      prefix: --no-validate-pixels
  - id: one_based
    type:
      - 'null'
      - boolean
    doc: Interpret genomic coordinates or bins as one/zero based. By default 
      coordinates are assumed to be one-based for interactions in 4dn and 
      validpairs formats and zero-based otherwise.
    inputBinding:
      position: 102
      prefix: --one-based
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: 'Output format (by default this is inferred from the output file extension).
      Should be one of: - auto - cool - hic'
    inputBinding:
      position: 102
      prefix: --output-fmt
  - id: skip_all_vs_all
    type:
      - 'null'
      - boolean
    doc: Do not generate All vs All matrix. Has no effect when creating .cool 
      files.
    inputBinding:
      position: 102
      prefix: --skip-all-vs-all
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of parallel threads to spawn. When loading interactions 
      in a .cool file, only up to two threads will be used.
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
  - id: transpose_lower_triangular_pixels
    type:
      - 'null'
      - boolean
    doc: Transpose pixels overlapping the lower-triangular matrix. When 
      --no-transpose-lower-triangular-pixels is used and one or more pixels 
      overlapping with the lower triangular matrix are encountered an exception 
      will be raised.
    inputBinding:
      position: 102
      prefix: --transpose-lower-triangular-pixels
  - id: validate_pixels
    type:
      - 'null'
      - boolean
    doc: Toggle pixel validation on or off. When --no-validate-pixels is used 
      and invalid pixels are encountered, hictk will either crash or produce 
      invalid files.
    inputBinding:
      position: 102
      prefix: --validate-pixels
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set verbosity of output to the console.
    inputBinding:
      position: 102
      prefix: --verbosity
  - id: zero_based
    type:
      - 'null'
      - boolean
    doc: Interpret genomic coordinates or bins as one/zero based. By default 
      coordinates are assumed to be one-based for interactions in 4dn and 
      validpairs formats and zero-based otherwise.
    inputBinding:
      position: 102
      prefix: --zero-based
outputs:
  - id: output_path
    type: File
    doc: Path to output file. File extension will be used to infer the output 
      format. This behavior can be overridden by explicitly specifying an output
      format through option --output-fmt.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
