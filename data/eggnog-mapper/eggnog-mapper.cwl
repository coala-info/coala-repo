cwlVersion: v1.2
class: CommandLineTool
baseCommand: emapper.py
label: eggnog-mapper
doc: "The provided text does not contain help information, but rather a system error
  log indicating a failure to pull the container image due to lack of disk space.
  eggnog-mapper is typically used for functional annotation of orthologous genes.\n
  \nTool homepage: https://github.com/jhcepas/eggnog-mapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eggnog-mapper:2.1.13--pyhdfd78af_2
stdout: eggnog-mapper.out
