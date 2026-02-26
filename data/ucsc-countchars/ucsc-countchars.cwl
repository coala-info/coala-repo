cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-countchars
label: ucsc-countchars
doc: "Counts characters in a FASTA or FASTQ file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA or FASTQ file
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write counts to
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-countchars:482--h0b57e2e_0
