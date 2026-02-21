cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - metassembly
label: harpy_metassembly
doc: "Assemble linked reads into a metagenome. The linked-read barcodes must be in
  BX:Z or BC:Z FASTQ header tags. It is strongly recommended to first deconvolve the
  input FASTQ files with harpy deconvolve.\n\nTool homepage: https://github.com/pdimens/harpy/"
inputs:
  - id: fastq_r1
    type: File
    doc: First read FASTQ file
    inputBinding:
      position: 1
  - id: fastq_r2
    type: File
    doc: Second read FASTQ file
    inputBinding:
      position: 2
  - id: bx_tag
    type:
      - 'null'
      - string
    doc: The header tag with the barcode (BX or BC)
    default: BX
    inputBinding:
      position: 103
      prefix: --bx-tag
  - id: container
    type:
      - 'null'
      - boolean
    doc: Use a container instead of conda
    inputBinding:
      position: 103
      prefix: --container
  - id: extra_params
    type:
      - 'null'
      - string
    doc: Additional spades parameters, in quotes
    inputBinding:
      position: 103
      prefix: --extra-params
  - id: hpc
    type:
      - 'null'
      - File
    doc: HPC submission YAML configuration file
    inputBinding:
      position: 103
      prefix: --hpc
  - id: kmer_length
    type:
      - 'null'
      - string
    doc: K values to use for assembly (odd and <128), separated by commas
    default: auto
    inputBinding:
      position: 103
      prefix: --kmer-length
  - id: max_memory
    type:
      - 'null'
      - int
    doc: Maximum memory for spades to use, in megabytes
    default: 10000
    inputBinding:
      position: 103
      prefix: --max-memory
  - id: organism_type
    type:
      - 'null'
      - string
    doc: Organism type for assembly report [eukaryote,prokaryote,fungus]
    default: eukaryote
    inputBinding:
      position: 103
      prefix: --organism-type
  - id: quiet
    type:
      - 'null'
      - int
    doc: 0 all output, 1 progress bar, 2 no output
    inputBinding:
      position: 103
      prefix: --quiet
  - id: skip_reports
    type:
      - 'null'
      - boolean
    doc: Don't generate HTML reports
    inputBinding:
      position: 103
      prefix: --skip-reports
  - id: snakemake
    type:
      - 'null'
      - string
    doc: Additional Snakemake parameters, in quotes
    inputBinding:
      position: 103
      prefix: --snakemake
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 4
    inputBinding:
      position: 103
      prefix: --threads
  - id: unlinked
    type:
      - 'null'
      - boolean
    doc: Treat input data as not linked reads
    inputBinding:
      position: 103
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
