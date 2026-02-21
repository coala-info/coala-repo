cwlVersion: v1.2
class: CommandLineTool
baseCommand: rhocall
label: rhocall
doc: "A tool for calling regions of homozygosity (ROH) from NGS data. (Note: The provided
  text contained container build logs and error messages rather than CLI help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/dnil/rhocall"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rhocall:0.5.1--py312h0fa9677_5
stdout: rhocall.out
