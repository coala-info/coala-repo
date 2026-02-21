cwlVersion: v1.2
class: CommandLineTool
baseCommand: srnaminer
label: srnaminer
doc: "A tool for sRNA-seq data analysis (Note: The provided text contains container
  build logs and error messages rather than CLI help documentation; therefore, no
  arguments could be extracted).\n\nTool homepage: https://github.com/kli28/sRNAminer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srnaminer:1.1.2--pyhdfd78af_0
stdout: srnaminer.out
