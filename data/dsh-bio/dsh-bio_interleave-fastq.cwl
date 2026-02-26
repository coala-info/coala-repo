cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-interleave-fastq
label: dsh-bio_interleave-fastq
doc: "Interleaves two FASTQ files into a single paired FASTQ file, with unpaired reads
  written to a separate file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: first_fastq_path
    type: File
    doc: first FASTQ input path
    inputBinding:
      position: 101
      prefix: --first-fastq-path
  - id: second_fastq_path
    type: File
    doc: second FASTQ input path
    inputBinding:
      position: 101
      prefix: --second-fastq-path
outputs:
  - id: paired_file
    type: File
    doc: output interleaved paired FASTQ file
    outputBinding:
      glob: $(inputs.paired_file)
  - id: unpaired_file
    type: File
    doc: output unpaired FASTQ file
    outputBinding:
      glob: $(inputs.unpaired_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
