cwlVersion: v1.2
class: CommandLineTool
baseCommand: gffpandas
label: gffpandas
doc: "A tool for processing GFF3 files using pandas. (Note: The provided help text
  contains only system error messages related to container execution and does not
  list specific arguments.)\n\nTool homepage: https://github.com/foerstner-lab/gffpandas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gffpandas:1.2.2--pyhdfd78af_0
stdout: gffpandas.out
