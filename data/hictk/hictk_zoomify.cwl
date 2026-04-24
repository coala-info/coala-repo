cwlVersion: v1.2
class: CommandLineTool
baseCommand: hictk zoomify
label: hictk_zoomify
doc: "Convert single-resolution Cooler and .hic files to multi-resolution by coarsening.\n\
  \nTool homepage: https://github.com/paulsengroup/hictk"
inputs:
  - id: input_file
    type: File
    doc: Path to a .cool or .hic file (Cooler URI syntax supported).
    inputBinding:
      position: 1
  - id: output_file
    type: File
    doc: Output path. When zoomifying Cooler files, providing a single 
      resolution through --resolutions and specifying --no-copy-base-resolution,
      the output file will be in .cool format.
    inputBinding:
      position: 2
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Number of pixels to buffer in memory. Only used when zoomifying .hic 
      files.
    inputBinding:
      position: 103
      prefix: --chunk-size
  - id: compression_lvl
    type:
      - 'null'
      - int
    doc: Compression level used to compress interactions. Defaults to 6 and 10 
      for .mcool and .hic files, respectively.
    inputBinding:
      position: 103
      prefix: --compression-lvl
  - id: copy_base_resolution
    type:
      - 'null'
      - boolean
    doc: Copy the base resolution to the output file.
    inputBinding:
      position: 103
      prefix: --copy-base-resolution
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite existing output file(s).
    inputBinding:
      position: 103
      prefix: --force
  - id: nice_steps
    type:
      - 'null'
      - boolean
    doc: Use nice or power of two steps to automatically generate the list of 
      resolutions.
    inputBinding:
      position: 103
      prefix: --nice-steps
  - id: no_copy_base_resolution
    type:
      - 'null'
      - boolean
    doc: Copy the base resolution to the output file.
    inputBinding:
      position: 103
      prefix: --no-copy-base-resolution
  - id: no_skip_all_vs_all
    type:
      - 'null'
      - boolean
    doc: Do not generate All vs All matrix. Has no effect when zoomifying .cool 
      files.
    inputBinding:
      position: 103
      prefix: --no-skip-all-vs-all
  - id: pow2_steps
    type:
      - 'null'
      - boolean
    doc: Use nice or power of two steps to automatically generate the list of 
      resolutions.
    inputBinding:
      position: 103
      prefix: --pow2-steps
  - id: resolutions
    type:
      - 'null'
      - type: array
        items: int
    doc: One or more resolutions to be used for coarsening.
    inputBinding:
      position: 103
      prefix: --resolutions
  - id: skip_all_vs_all
    type:
      - 'null'
      - boolean
    doc: Do not generate All vs All matrix. Has no effect when zoomifying .cool 
      files.
    inputBinding:
      position: 103
      prefix: --skip-all-vs-all
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of parallel threads to spawn. When zoomifying 
      interactions from a .cool file, only a single thread will be used.
    inputBinding:
      position: 103
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Path to a folder where to store temporary data.
    inputBinding:
      position: 103
      prefix: --tmpdir
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set verbosity of output to the console.
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
stdout: hictk_zoomify.out
