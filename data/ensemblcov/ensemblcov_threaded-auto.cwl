cwlVersion: v1.2
class: CommandLineTool
baseCommand: ensemblcov threaded-auto
label: ensemblcov_threaded-auto
doc: "threaded version of ensembl auto gene conversion\n\nTool homepage: https://github.com/IBCHgenomic/ensemlcov"
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
stdout: ensemblcov_threaded-auto.out
