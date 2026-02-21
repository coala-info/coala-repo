cwlVersion: v1.2
class: CommandLineTool
baseCommand: sap-ui
label: snakealtpromoter_sap-ui
doc: "SnakeAltPromoter UI (Note: The provided text appears to be a container build
  log rather than help text; no arguments could be extracted).\n\nTool homepage: https://github.com/YidanSunResearchLab/SnakeAltPromoter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakealtpromoter:1.0.5--pyhdfd78af_0
stdout: snakealtpromoter_sap-ui.out
