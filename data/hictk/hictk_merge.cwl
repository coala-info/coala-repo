cwlVersion: v1.2
class: CommandLineTool
baseCommand: hictk merge
label: hictk_merge
doc: "Merge multiple Cooler or .hic files into a single file.\n\nTool homepage: https://github.com/paulsengroup/hictk"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Path to two or more Cooler or .hic files to be merged (Cooler URI 
      syntax supported).
    inputBinding:
      position: 1
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Number of pixels to store in memory before writing to disk.
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
    doc: Specify the count type to be used when merging files. Ignored when the 
      output file is in .hic format.
    inputBinding:
      position: 102
      prefix: --count-type
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file.
    inputBinding:
      position: 102
      prefix: --force
  - id: no_skip_all_vs_all
    type:
      - 'null'
      - boolean
    doc: Do not generate All vs All matrix. Has no effect when merging .cool 
      files.
    inputBinding:
      position: 102
      prefix: --no-skip-all-vs-all
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: Output format (by default this is inferred from the output file 
      extension).
    inputBinding:
      position: 102
      prefix: --output-fmt
  - id: resolution
    type:
      - 'null'
      - int
    doc: Hi-C matrix resolution (ignored when input files are in .cool format).
    inputBinding:
      position: 102
      prefix: --resolution
  - id: skip_all_vs_all
    type:
      - 'null'
      - boolean
    doc: Do not generate All vs All matrix. Has no effect when merging .cool 
      files.
    inputBinding:
      position: 102
      prefix: --skip-all-vs-all
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of parallel threads to spawn. When merging interactions 
      in Cooler format, only a single thread will be used.
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
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output_file
    type: File
    doc: Output Cooler or .hic file (Cooler URI syntax supported).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hictk:2.2.0--h75fee6f_0
