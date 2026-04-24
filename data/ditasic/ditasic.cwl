cwlVersion: v1.2
class: CommandLineTool
baseCommand: ditasic
label: ditasic
doc: "Differential Taxon Abundance Subtraction and Intersection Counting for accurate
  profiling of metagenomes.\n\nTool homepage: https://rki_bioinformatics.gitlab.io/ditasic/"
inputs:
  - id: subcommand
    type: string
    doc: "Subcommand to run: 'build' to create a reference index or 'run' to perform
      abundance estimation."
    inputBinding:
      position: 1
  - id: prefix
    type: string
    doc: Prefix for the index files or output files.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: query
    type:
      - 'null'
      - File
    doc: Query sequences (BAM/SAM format) for the 'run' subcommand.
    inputBinding:
      position: 102
      prefix: --query
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequences (FASTA format) for the 'build' subcommand.
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for processing.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to the output file for abundance estimates.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ditasic:0.2--py37h470a237_0
