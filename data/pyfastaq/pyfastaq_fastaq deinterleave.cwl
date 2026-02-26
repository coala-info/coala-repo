cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfastaq
  - fastaq
  - deinterleave
label: pyfastaq_fastaq deinterleave
doc: "Deinterleaves a FASTAQ file into two separate FASTAQ files.\n\nTool homepage:
  https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: input_file
    type: File
    doc: The input FASTAQ file to deinterleave.
    inputBinding:
      position: 1
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: If set, the input file is assumed to be interleaved (one FASTA, one 
      FASTQ, one FASTA, one FASTQ, etc.).
    inputBinding:
      position: 102
      prefix: --interleaved
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: The output FASTA file for the first sequence type.
    outputBinding:
      glob: $(inputs.output_fasta)
  - id: output_fastq
    type:
      - 'null'
      - File
    doc: The output FASTQ file for the second sequence type.
    outputBinding:
      glob: $(inputs.output_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
