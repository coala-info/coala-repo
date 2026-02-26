cwlVersion: v1.2
class: CommandLineTool
baseCommand: RevComplement
label: rdp-readseq_reverse-comp
doc: Reverse complement a DNA sequence
inputs:
  - id: check_orientation
    type:
      - 'null'
      - boolean
    doc: If set, will check orientation of the rRNA sequenc, only reverse 
      complement if needed
    inputBinding:
      position: 101
      prefix: --check
  - id: input_file
    type:
      - 'null'
      - File
    doc: input fasta file
    inputBinding:
      position: 101
      prefix: --infile
  - id: output_format
    type:
      - 'null'
      - string
    doc: output format, fasta or fastq.
    default: fasta
    inputBinding:
      position: 101
      prefix: --format
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output fasta file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
