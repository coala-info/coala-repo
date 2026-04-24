cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfastaq
  - fastaq
  - to_fake_qual
label: pyfastaq_fastaq to_fake_qual
doc: "Convert FASTA to FASTQ with fake quality scores.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists
    inputBinding:
      position: 102
  - id: quality
    type:
      - 'null'
      - int
    doc: 'Quality score to use for all bases [default: 40]'
    inputBinding:
      position: 102
outputs:
  - id: output_fastq
    type: File
    doc: Output FASTQ file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
