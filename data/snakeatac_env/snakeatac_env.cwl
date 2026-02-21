cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakeatac_env
label: snakeatac_env
doc: "SnakeATAC environment container (biocontainer)\n\nTool homepage: https://github.com/sebastian-gregoricchio/snakeATAC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakeatac_env:0.1.1--pyha70a07d_0
stdout: snakeatac_env.out
