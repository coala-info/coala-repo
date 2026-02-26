cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ensemblcov
  - auto-generate
label: ensemblcov_auto-generate
doc: "autogenerate the ensemble gene conversion\n\nTool homepage: https://github.com/IBCHgenomic/ensemlcov"
inputs:
  - id: generate
    type: string
    doc: provide yes as argument
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
stdout: ensemblcov_auto-generate.out
