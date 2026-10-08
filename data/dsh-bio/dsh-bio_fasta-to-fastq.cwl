cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dsh-fasta-to-fastq
label: dsh-bio_fasta-to-fastq
doc: "convert DNA sequences in FASTA format to FASTQ format\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_fasta_path
    type: File
    doc: "input FASTA path, default stdin"
    inputBinding:
      position: 101
      prefix: --input-fasta-path
  - id: output_fastq_file_path
    type: string
    doc: "output FASTQ file, default stdout"
    inputBinding:
      position: 101
      prefix: --output-fastq-file
  - id: quality
    type:
      - 'null'
      - int
    doc: "quality score for FASTQ, [0..93], default 40"
    inputBinding:
      position: 101
      prefix: --quality
outputs:
  - id: output_fastq_file
    type:
      - 'null'
      - File
    doc: "output FASTQ file, default stdout"
    outputBinding:
      glob: $(inputs.output_fastq_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
