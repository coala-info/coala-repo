cwlVersion: v1.2
class: CommandLineTool
baseCommand: mason_genome
label: mason_mason_genome
doc: "Simulate a random genome to the output file. For each -l/--contig-length entry, a contig with the given length will be simulated.\n\nTool homepage: https://www.seqan.de/apps/mason.html"
inputs:
  - id: contig_length
    type:
      type: array
      items: long
      inputBinding:
        prefix: -l
    doc: "Length of the contig to simulate. Give one -l value for each contig to simulate. In range [1..inf]."
    inputBinding:
      position: 101
  - id: version_check
    type:
      - 'null'
      - string
    doc: "Turn this option off to disable version update notifications of the application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO."
    inputBinding:
      position: 101
      prefix: --version-check
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Set verbosity to a minimum."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable verbose output."
    inputBinding:
      position: 101
      prefix: --verbose
  - id: very_verbose
    type:
      - 'null'
      - boolean
    doc: "Enable very verbose output."
    inputBinding:
      position: 101
      prefix: --very-verbose
  - id: seed
    type:
      - 'null'
      - long
    doc: "The seed to use for the random number generator. Default: 42."
    inputBinding:
      position: 101
      prefix: --seed
  - id: out_file_path
    type: string
    doc: "Output file (e.g. genome.fa)."
    inputBinding:
      position: 103
      prefix: --out-file
outputs:
  - id: out_file
    type: File
    doc: Output file with the simulated genome.
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mason:2.0.13--h7f3286b_0
