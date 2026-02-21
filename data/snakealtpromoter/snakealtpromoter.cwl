cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakealtpromoter
label: snakealtpromoter
doc: "A tool for alternative promoter analysis (Note: The provided help text contains
  only container build logs and no usage information).\n\nTool homepage: https://github.com/YidanSunResearchLab/SnakeAltPromoter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakealtpromoter:1.0.5--pyhdfd78af_0
stdout: snakealtpromoter.out
