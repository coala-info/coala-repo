cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bakrep-cli
  - report
label: bakrep-cli
doc: "Bacterial Report CLI tool for generating reports from assembly FASTA files.\n
  \nTool homepage: https://github.com/oschwengers/bakrep-cli"
inputs:
  - id: fasta
    type: File
    doc: Input assembly FASTA file
    inputBinding:
      position: 1
  - id: species
    type:
      - 'null'
      - string
    doc: Species name for the analysis
    inputBinding:
      position: 102
      prefix: --species
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: outdir
    type: Directory
    doc: Output directory for the report
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bakrep-cli:1.1.0--pyhdfd78af_0
