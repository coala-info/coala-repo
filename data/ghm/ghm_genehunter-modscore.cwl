cwlVersion: v1.2
class: CommandLineTool
baseCommand: ghm
label: ghm_genehunter-modscore
doc: "Genehunter-modscore (ghm) is a tool for linkage analysis. Note: The provided
  help text contains only system error messages regarding container execution and
  does not list command-line arguments.\n\nTool homepage: https://www.helmholtz-muenchen.de/en/ige/service/software-download/genehunter-modscore/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ghm:3.1--ha92aebf_2
stdout: ghm_genehunter-modscore.out
