cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - elprep
  - fasta-to-elfasta
label: elprep_fasta-to-elfasta
doc: "Converts a FASTA file to an elFASTA file.\n\nTool homepage: https://github.com/ExaScience/elprep"
inputs:
  - id: fasta_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: log_path
    type:
      - 'null'
      - Directory
    doc: Path to store logs
    inputBinding:
      position: 102
      prefix: --log-path
outputs:
  - id: elfasta_file
    type: File
    doc: Output elFASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elprep:5.1.3--he881be0_2
