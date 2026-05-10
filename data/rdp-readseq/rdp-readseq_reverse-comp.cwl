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
    inputBinding:
      position: 101
      prefix: --format
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output fasta file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
