cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - fasta_to_fastq
label: pyfastaq_fastaq_fasta_to_fastq
doc: "Convert FASTA and .qual to FASTQ\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: fasta
    type: File
    doc: "Name of input FASTA file"
    inputBinding:
      position: 20
  - id: qual
    type: File
    doc: "Name of input quality scores file"
    inputBinding:
      position: 21
  - id: outfile
    type: string
    doc: "Name of output FASTQ file"
    inputBinding:
      position: 22
outputs:
  - id: output
    type: File
    doc: "Name of output FASTQ file"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
