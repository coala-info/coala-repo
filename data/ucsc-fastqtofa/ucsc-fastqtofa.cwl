cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqToFa
label: ucsc-fastqtofa
doc: "A tool to convert FASTQ files to FASTA format. (Note: The provided help text
  contains only system error messages and no usage information; arguments could not
  be extracted from the source text.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fastqtofa:482--h0b57e2e_0
stdout: ucsc-fastqtofa.out
