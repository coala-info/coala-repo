cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfastaq
  - fastaq
  - sort_by_size
label: pyfastaq_fastaq sort_by_size
doc: "Sort FASTA/FASTQ files by sequence length.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTA/FASTQ file(s)
    inputBinding:
      position: 1
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Sort in reverse order (longest first)
    inputBinding:
      position: 102
      prefix: --reverse
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
