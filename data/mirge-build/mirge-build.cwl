cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirge-build
label: mirge-build
doc: "Builds MIRGE database.\n\nTool homepage: https://github.com/mhalushka/miRge3_build"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file containing miRNA sequences.
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing database files if they exist.
    inputBinding:
      position: 102
      prefix: --force
  - id: output_dir
    type: Directory
    doc: Directory to store the built database.
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for building the database.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirge-build:0.0.1--pyh3252c3a_0
stdout: mirge-build.out
