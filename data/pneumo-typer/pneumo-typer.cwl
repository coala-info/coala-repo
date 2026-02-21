cwlVersion: v1.2
class: CommandLineTool
baseCommand: pneumo-typer
label: pneumo-typer
doc: "A tool for serotyping Streptococcus pneumoniae (Note: The provided text is a
  container runtime error log and does not contain help documentation or argument
  definitions).\n\nTool homepage: https://www.microbialgenomic.cn/Pneumo-Typer.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pneumo-typer:2.0.1--hdfd78af_0
stdout: pneumo-typer.out
