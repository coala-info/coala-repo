cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - qc
label: harpy_qc
doc: "FASTQ adapter removal, quality filtering, etc. Linked-read presence and type
  is auto-detected.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Input fastq files and/or directories
    inputBinding:
      position: 1
  - id: container
    type:
      - 'null'
      - boolean
    doc: Use a container instead of conda
    inputBinding:
      position: 102
      prefix: --container
  - id: deduplicate
    type:
      - 'null'
      - boolean
    doc: Identify and remove PCR duplicates
    inputBinding:
      position: 102
      prefix: --deduplicate
  - id: extra_params
    type:
      - 'null'
      - string
    doc: Additional Fastp parameters, in quotes
    inputBinding:
      position: 102
      prefix: --extra-params
  - id: hpc
    type:
      - 'null'
      - File
    doc: HPC submission YAML configuration file
    inputBinding:
      position: 102
      prefix: --hpc
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length to trim sequences down to
    default: 150
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Discard reads shorter than this length
    default: 30
    inputBinding:
      position: 102
      prefix: --min-length
  - id: quiet
    type:
      - 'null'
      - int
    doc: 0 all output, 1 progress bar, 2 no output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: skip_reports
    type:
      - 'null'
      - boolean
    doc: Don't generate HTML reports
    inputBinding:
      position: 102
      prefix: --skip-reports
  - id: snakemake
    type:
      - 'null'
      - string
    doc: Additional Snakemake parameters, in quotes
    inputBinding:
      position: 102
      prefix: --snakemake
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 4
    inputBinding:
      position: 102
      prefix: --threads
  - id: trim_adapters
    type:
      - 'null'
      - string
    doc: Detect and trim adapters; accepts 'auto' or a FASTA file
    inputBinding:
      position: 102
      prefix: --trim-adapters
  - id: unlinked
    type:
      - 'null'
      - boolean
    doc: Treat input data as not linked reads
    inputBinding:
      position: 102
      prefix: --unlinked
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory name
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
