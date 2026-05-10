cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Meteor
  - fastq
label: meteor_fastq
doc: "Create a fastq repository from a directory containing fastq files.\n\nTool homepage:
  https://github.com/metagenopolis/meteor"
inputs:
  - id: input_fastq_dir
    type: Directory
    doc: 'Directory containing all input fastq files with .fastq or .fq. extensions
      (gzip, bzip2 and xz compression accepted). Paired-end files must be named :
      file_R1.[fastq/fq] & file_R2.[fastq/fq] or file_1.[fastq/fq] & file_2.[fastq/fq]'
    inputBinding:
      position: 101
      prefix: -i
  - id: mask_sample_name
    type:
      - 'null'
      - string
    doc: Regular expression (between quotes) for extracting sample name.
    inputBinding:
      position: 101
      prefix: -m
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Fastq files are paired.
    inputBinding:
      position: 101
      prefix: -p
  - id: fastq_dir_path
    type: string
    doc: Output or path parameter `fastq_dir_path`
    inputBinding:
      position: 102
      prefix: --fastq-dir
outputs:
  - id: fastq_dir
    type: Directory
    doc: Directory where the fastq repository is created.
    outputBinding:
      glob: $(inputs.fastq_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
