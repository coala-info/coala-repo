cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylopandas
label: phylopandas
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://github.com/Zsailer/phylopandas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylopandas:0.8.0--py_0
stdout: phylopandas.out
