cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqzcomp
label: fqzcomp_fastq_comp
doc: "A tool for FASTQ compression (Note: The provided help text contains only system
  error messages regarding container image building and disk space, so specific arguments
  could not be extracted).\n\nTool homepage: https://sourceforge.net/projects/fqzcomp/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqzcomp:4.6--h077b44d_6
stdout: fqzcomp_fastq_comp.out
