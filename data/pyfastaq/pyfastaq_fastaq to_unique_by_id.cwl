cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfastaq
  - fastaq
  - to_unique_by_id
label: pyfastaq_fastaq to_unique_by_id
doc: "Remove duplicate sequences from a FASTA or FASTQ file, keeping only the first
  occurrence of each sequence ID.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA or FASTQ file.
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output FASTA or FASTQ file. If not specified, output will be written to
      stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
