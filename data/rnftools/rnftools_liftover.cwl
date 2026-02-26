cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rnftools
  - liftover
label: rnftools_liftover
doc: "Liftover genomic coordinates in RNF names in a SAM/BAM files or in a FASTQ file.\n\
  \nTool homepage: http://karel-brinda.github.io/rnftools"
inputs:
  - id: input
    type: File
    doc: Input file to be transformed (- for standard input).
    inputBinding:
      position: 1
  - id: chain_file
    type:
      - 'null'
      - File
    doc: Chain liftover file for coordinates transformation. [no transformation]
    inputBinding:
      position: 102
      prefix: --chain
  - id: faidx_file
    type:
      - 'null'
      - File
    doc: Fasta index of the reference sequence. [extract from chain file]
    inputBinding:
      position: 102
      prefix: --faidx
  - id: genome_id
    type: int
    doc: ID of genome to be transformed.
    inputBinding:
      position: 102
      prefix: --genome-id
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input format (SAM/BAM/FASTQ). [autodetect]
    inputBinding:
      position: 102
      prefix: --input-format
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Invert chain file (transformation in the other direction).
    inputBinding:
      position: 102
      prefix: --invert
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format (SAM/BAM/FASTQ). [autodetect]
    inputBinding:
      position: 102
      prefix: --output-format
outputs:
  - id: output
    type: File
    doc: Output file to be transformed (- for standard output).
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnftools:0.4.0.0--pyhdfd78af_0
