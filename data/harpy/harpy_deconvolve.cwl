cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - deconvolve
label: harpy_deconvolve
doc: "Resolve barcode sharing in unrelated molecules. Provide the input fastq files
  and/or directories at the end of the command.\n\nTool homepage: https://github.com/pdimens/harpy/"
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
  - id: density
    type:
      - 'null'
      - int
    doc: On average, 1/2^d kmers are indexed
    default: 3
    inputBinding:
      position: 102
      prefix: --density
  - id: dropout
    type:
      - 'null'
      - int
    doc: Minimum cloud size to deconvolve
    default: 0
    inputBinding:
      position: 102
      prefix: --dropout
  - id: hpc
    type:
      - 'null'
      - File
    doc: HPC submission YAML configuration file
    inputBinding:
      position: 102
      prefix: --hpc
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Size of kmers
    default: 21
    inputBinding:
      position: 102
      prefix: --kmer-length
  - id: quiet
    type:
      - 'null'
      - int
    doc: 0 all output, 1 progress bar, 2 no output
    inputBinding:
      position: 102
      prefix: --quiet
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
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of window guaranteed to contain at least one kmer
    default: 40
    inputBinding:
      position: 102
      prefix: --window-size
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
