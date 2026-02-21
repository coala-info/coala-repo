cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snakealtpromoter
  - Genomesetup
label: snakealtpromoter_Genomesetup
doc: "Genome setup for snakealtpromoter. (Note: The provided text contains system
  logs and error messages rather than command-line help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/YidanSunResearchLab/SnakeAltPromoter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakealtpromoter:1.0.5--pyhdfd78af_0
stdout: snakealtpromoter_Genomesetup.out
