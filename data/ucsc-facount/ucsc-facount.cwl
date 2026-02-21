cwlVersion: v1.2
class: CommandLineTool
baseCommand: faCount
label: ucsc-facount
doc: "Count bases in FASTA files. (Note: The provided text is a container execution
  error log and does not contain the tool's help documentation; therefore, arguments
  could not be extracted from the source text.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-facount:482--h0b57e2e_0
stdout: ucsc-facount.out
