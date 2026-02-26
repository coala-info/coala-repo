cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnaapler archaea
label: dnaapler_archaea
doc: "Run dnaapler on archaea genomes\n\nTool homepage: https://github.com/gbouras13/dnaapler"
inputs:
  - id: autocomplete
    type:
      - 'null'
      - string
    doc: 'Choose an option to autocomplete reorientation if MMseqs2 based approach
      fails. Must be one of: none, mystery, largest, or nearest'
    default: none
    inputBinding:
      position: 101
      prefix: --autocomplete
  - id: evalue
    type:
      - 'null'
      - string
    doc: E-value for MMseqs2
    default: '1e-10'
    inputBinding:
      position: 101
      prefix: --evalue
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrites the output directory
    inputBinding:
      position: 101
      prefix: --force
  - id: input_file
    type: File
    doc: Path to input file in FASTA or GFA format
    inputBinding:
      position: 101
      prefix: --input
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    default: dnaapler
    inputBinding:
      position: 101
      prefix: --prefix
  - id: seed_value
    type:
      - 'null'
      - int
    doc: Random seed to ensure reproducibility.
    default: 13
    inputBinding:
      position: 101
      prefix: --seed_value
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use with MMseqs2
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
