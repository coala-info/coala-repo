cwlVersion: v1.2
class: CommandLineTool
baseCommand: fufihla
label: fufihla
doc: "Functional Filtering of HMM-based Local Alignments (Note: The provided help
  text contains only container runtime error messages and no usage information).\n
  \nTool homepage: https://github.com/jingqing-hu/FuFiHLA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fufihla:0.2.3--hdfd78af_0
stdout: fufihla.out
