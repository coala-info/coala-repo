cwlVersion: v1.2
class: CommandLineTool
baseCommand: rampler
label: rampler
doc: "A tool for sampling and splitting genomic sequences.\n\nTool homepage: https://github.com/rvaser/rampler"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (subsample or split)
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Input genomic sequences in FASTA/FASTQ format
    inputBinding:
      position: 2
  - id: number_of_sequences
    type:
      - 'null'
      - int
    doc: Number of sequences to subsample
    inputBinding:
      position: 103
      prefix: --number-of-sequences
  - id: proportion
    type:
      - 'null'
      - float
    doc: Proportion of sequences to subsample
    inputBinding:
      position: 103
      prefix: --proportion
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the random number generator
    inputBinding:
      position: 103
      prefix: --seed
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 104
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to the output file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rampler:v1.1.0-1-deb_cv1
