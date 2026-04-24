cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blobtk
  - filter
label: blobtk_filter
doc: "Filter files based on list of sequence names.\n\nTool homepage: https://github.com/genomehubs/blobtk"
inputs:
  - id: assembly_fasta
    type:
      - 'null'
      - File
    doc: Path to assembly FASTA input file (required for CRAM)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: bam_file
    type:
      - 'null'
      - File
    doc: Path to BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: cram_file
    type:
      - 'null'
      - File
    doc: Path to CRAM file
    inputBinding:
      position: 101
      prefix: --cram
  - id: fastq2_file
    type:
      - 'null'
      - File
    doc: Path to paired FASTQ file to filter (reverse reads)
    inputBinding:
      position: 101
      prefix: --fastq2
  - id: fastq_file
    type:
      - 'null'
      - File
    doc: Path to FASTQ file to filter (forward or single reads)
    inputBinding:
      position: 101
      prefix: --fastq
  - id: list_file
    type: File
    doc: Path to input file containing a list of sequence IDs
    inputBinding:
      position: 101
      prefix: --list
  - id: output_fasta
    type:
      - 'null'
      - boolean
    doc: Flag to output a filtered FASTA file
    inputBinding:
      position: 101
      prefix: --fasta-out
  - id: output_fastq
    type:
      - 'null'
      - boolean
    doc: Flag to output filtered FASTQ files
    inputBinding:
      position: 101
      prefix: --fastq-out
  - id: output_suffix
    type:
      - 'null'
      - string
    doc: Suffix to use for output filtered files
    inputBinding:
      position: 101
      prefix: --suffix
outputs:
  - id: read_list_output
    type:
      - 'null'
      - File
    doc: Path to output list of read IDs
    outputBinding:
      glob: $(inputs.read_list_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtk:0.7.1--py39hf6b2c50_0
