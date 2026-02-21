cwlVersion: v1.2
class: CommandLineTool
baseCommand: cured
label: cured
doc: "Clean Unwanted Reads from Environmental Datasets (CURED). A tool for removing
  contamination from metagenomic or genomic sequencing data.\n\nTool homepage: https://github.com/microbialARC/CURED"
inputs:
  - id: input_file
    type: File
    doc: Input FASTQ file (gzipped supported)
    inputBinding:
      position: 101
      prefix: --input
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keep intermediate temporary files
    inputBinding:
      position: 101
      prefix: --keep
  - id: memory
    type:
      - 'null'
      - string
    doc: Maximum memory to use (e.g., 8G)
    inputBinding:
      position: 101
      prefix: --memory
  - id: reference_file
    type: File
    doc: Reference genome or database to filter against
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of computational threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: Path to write the cleaned output FASTQ file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cured:1.05--hdfd78af_0
