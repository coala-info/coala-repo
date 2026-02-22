cwlVersion: v1.2
class: CommandLineTool
baseCommand: bis-snp
label: bis-snp
doc: "Bis-SNP is a tool for genotyping and DNA methylation calling in bisulfite-seq
  data. (Note: The provided text contained system error messages rather than help
  text; no arguments could be extracted from the input.)\n\nTool homepage: http://people.csail.mit.edu/dnaase/bissnp2011/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bis-snp:1.0.1--0
stdout: bis-snp.out
