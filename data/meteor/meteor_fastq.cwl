cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - meteor
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
    doc: Directory where the fastq repository is created.
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: fastq_dir
    type: Directory
    doc: Directory where the fastq repository is created.
    outputBinding:
      glob: $(inputs.fastq_dir_path)
arguments:
  - position: 1000
    shellQuote: false
    valueFrom: '&& for l in `find $(inputs.fastq_dir_path) -type l`; do cp -L "$l" "$l.tmp" && mv -f "$l.tmp" "$l"; done'
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
