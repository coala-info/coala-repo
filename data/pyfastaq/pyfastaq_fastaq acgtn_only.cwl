cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastaq_fastaq acgtn_only
label: pyfastaq_fastaq acgtn_only
doc: "Filter FASTA/FASTQ sequences to only include ACGTN characters.\n\nTool homepage:
  https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA or FASTQ file
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Output FASTA or FASTQ file (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
