cwlVersion: v1.2
class: CommandLineTool
baseCommand: bis-snp_BisSNP.jar
label: bis-snp_BisSNP.jar
doc: "Bis-SNP is a tool for SNP calling and cytosine methylation detection in bisulfite-sequencing
  data. (Note: The provided text contains system error messages regarding container
  execution and does not list command-line arguments.)\n\nTool homepage: http://people.csail.mit.edu/dnaase/bissnp2011/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bis-snp:1.0.1--0
stdout: bis-snp_BisSNP.jar.out
