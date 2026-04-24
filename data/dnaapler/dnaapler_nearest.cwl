cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnaapler nearest
label: dnaapler_nearest
doc: "Find the nearest reference genome for each input sequence.\n\nTool homepage:
  https://github.com/gbouras13/dnaapler"
inputs:
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
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use with MMseqs2
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
stdout: dnaapler_nearest.out
