cwlVersion: v1.2
class: CommandLineTool
baseCommand: hitad
label: tadlib_hitad
doc: "A highly sensitive and reproducible hierarchical domain caller.\n\nTool homepage:
  https://github.com/XiaoTaoWang/TADLib/"
inputs:
  - id: cpu_core
    type:
      - 'null'
      - int
    doc: Number of processes to launch.
    inputBinding:
      position: 101
      prefix: --cpu-core
  - id: cool_files
    type:
      type: array
      items: File
    doc: Cool files named in the metadata file (staged writable, because hitad writes the DI track into the cool file)
  - id: datasets
    type: File
    doc: "Metadata file describing Hi-C datasets. Refer to our\n                 \
      \       online documentation for more details."
    inputBinding:
      position: 101
      prefix: --datasets
  - id: di_col
    type:
      - 'null'
      - string
    doc: Name of the column in .cool to output the DI track
    inputBinding:
      position: 101
      prefix: --DI-col
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: List of chromosomes to exclude. - chrY - chrM
    inputBinding:
      position: 101
      prefix: --exclude
  - id: log_file
    type:
      - 'null'
      - string
    doc: Logging file name.
    inputBinding:
      position: 101
      prefix: --logFile
  - id: maxsize
    type:
      - 'null'
      - int
    doc: Maximum domain size in base-pair unit.
    inputBinding:
      position: 101
      prefix: --maxsize
  - id: minimum_chrom_size
    type:
      - 'null'
      - int
    doc: "Minimum chromosome size. Only chromosomes with a size\n                \
      \        greater than this value will be considered."
    inputBinding:
      position: 101
      prefix: --minimum-chrom-size
  - id: remove_cache
    type:
      - 'null'
      - boolean
    doc: Remove cache data before exiting.
    inputBinding:
      position: 101
      prefix: --removeCache
  - id: weight_col
    type:
      - 'null'
      - string
    doc: "Name of the column in .cool to be used to construct\n                  \
      \      the normalized matrix. Specify \"-W RAW\" if you want to\n          \
      \              run with the raw matrix."
    inputBinding:
      position: 101
      prefix: --weight-col
  - id: output_path
    type: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.output_path)
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log_file || 'hitad.log')
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.cool_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadlib:0.4.5.post1--pyhdfd78af_1
