cwlVersion: v1.2
class: CommandLineTool
baseCommand: hictk convert
label: hictk_convert
doc: "Convert Hi-C files between different formats.\n\nTool homepage: https://github.com/paulsengroup/hictk"
inputs:
  - id: input
    type: File
    doc: Path to the .hic, .cool or .mcool file to be converted.
    inputBinding:
      position: 1
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Batch size to use when converting .[m]cool to .hic.
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
  - id: count_type
    type:
      - 'null'
      - string
    doc: 'Specify the strategy used to infer count types when converting .hic files
      to .[m]cool format. Can be one of: int, float, or auto.'
    inputBinding:
      position: 102
      prefix: --count-type
  - id: fail_if_norm_not_found
    type:
      - 'null'
      - boolean
    doc: Fail if any of the requested normalization vectors are missing.
    inputBinding:
      position: 102
      prefix: --fail-if-norm-not-found
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files (if any).
    inputBinding:
      position: 102
      prefix: --force
  - id: genome
    type:
      - 'null'
      - string
    doc: Genome assembly name. By default this is copied from the .hic file 
      metadata.
    inputBinding:
      position: 102
      prefix: --genome
  - id: no_skip_all_vs_all
    type:
      - 'null'
      - boolean
    doc: Do not generate All vs All matrix. Has no effect when creating .[m]cool
      files.
    inputBinding:
      position: 102
      prefix: --no-skip-all-vs-all
  - id: normalization_methods
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of one or more normalization methods to be copied. By default, 
      vectors for all known normalization methods are copied. Pass NONE to avoid
      copying the normalization vectors.
    inputBinding:
      position: 102
      prefix: --normalization-methods
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: Output format (by default this is inferred from the output file 
      extension).
    inputBinding:
      position: 102
      prefix: --output-fmt
  - id: resolutions
    type:
      - 'null'
      - type: array
        items: int
    doc: One or more resolutions to be converted. By default all resolutions are
      converted.
    inputBinding:
      position: 102
      prefix: --resolutions
  - id: skip_all_vs_all
    type:
      - 'null'
      - boolean
    doc: Do not generate All vs All matrix. Has no effect when creating .[m]cool
      files.
    inputBinding:
      position: 102
      prefix: --skip-all-vs-all
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of parallel threads to spawn. When converting from hic 
      to cool, only two threads will be used.
    inputBinding:
      position: 102
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Path where to store temporary files.
    inputBinding:
      position: 102
      prefix: --tmpdir
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set verbosity of output to the console.
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output
    type: File
    doc: Output path. File extension is used to infer output format.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
