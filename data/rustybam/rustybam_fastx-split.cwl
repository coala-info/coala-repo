cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rustybam
  - fastx-split
label: rustybam_fastx-split
doc: "Splits fastx from stdin into multiple files. It reads fastx format (fastq, fasta,
  or mixed) from stdin and divides the records across multiple output files. Output
  files can be compressed by adding `.gz`.\n\nTool homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: input_fastx
    type: File
    doc: FASTA/FASTQ file to split (plain or gzip), read from STDIN
  - id: fastx_files
    type:
      type: array
      items: string
    doc: List of fastx files to write to
    inputBinding:
      position: 1
outputs:
  - id: split_files
    type:
      type: array
      items: File
    doc: The fastx chunk files
    outputBinding:
      glob: $(inputs.fastx_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdin: $(inputs.input_fastx.path)
