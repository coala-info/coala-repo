cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - qc
label: harpy_qc
doc: FASTQ adapter removal, quality filtering, etc. Linked-read presence and 
  type is auto-detected.
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Input fastq files and/or directories
    inputBinding:
      position: 1
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
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length to trim sequences down to
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Discard reads shorter than this length
    inputBinding:
      position: 102
      prefix: --min-length
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
  - id: output_dir
    type: string
    doc: Output directory name
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: container
    type:
      - 'null'
      - boolean
    doc: Use a container instead of conda
    inputBinding:
      position: 102
      prefix: --container
  - id: hpc
    type:
      - 'null'
      - File
    doc: HPC submission YAML configuration file
    inputBinding:
      position: 102
      prefix: --hpc
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
outputs:
  - id: output_output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory name
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
s:url: https://github.com/pdimens/harpy/
$namespaces:
  s: https://schema.org/
