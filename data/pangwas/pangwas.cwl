cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangwas
label: pangwas
doc: "A tool for Pan-Genome Wide Association Studies (Pan-GWAS). Note: The provided
  text contains system error messages regarding container execution and does not list
  specific command-line arguments.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
stdout: pangwas.out
