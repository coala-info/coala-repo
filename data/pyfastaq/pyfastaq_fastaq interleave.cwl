cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - interleave
label: pyfastaq_fastaq interleave
doc: "Interleave two FASTA files.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: file1
    type: File
    doc: First FASTA file
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: Second FASTA file
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists
    inputBinding:
      position: 103
      prefix: --force
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Output FASTA file (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
