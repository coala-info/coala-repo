cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - fastq-split
label: rust-bio-tools_fastq-split
doc: "Split FASTQ file from STDIN into N chunks.\n\nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: fastq
    type: File
    doc: FASTQ file to split (read from STDIN)
  - id: chunks
    type:
      type: array
      items: string
    doc: File name(s) for the chunks to create.
    inputBinding:
      position: 1
outputs:
  - id: chunk_files
    type:
      type: array
      items: File
    doc: FASTQ chunk files
    outputBinding:
      glob: $(inputs.chunks)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
stdin: $(inputs.fastq.path)
