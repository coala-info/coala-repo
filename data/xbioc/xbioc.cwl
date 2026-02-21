cwlVersion: v1.2
class: CommandLineTool
baseCommand: xbioc
label: xbioc
doc: "A tool from the Bioconductor suite (xbioc), typically used in R environments
  for biological data analysis. Note: The provided text contains build logs and error
  messages rather than standard CLI help documentation.\n\nTool homepage: https://github.com/renozao/xbioc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xbioc:0.1.19--r44hdfd78af_4
stdout: xbioc.out
