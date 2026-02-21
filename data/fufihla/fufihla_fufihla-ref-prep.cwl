cwlVersion: v1.2
class: CommandLineTool
baseCommand: fufihla-ref-prep
label: fufihla_fufihla-ref-prep
doc: "Reference preparation tool for fufihla. (Note: The provided text contains container
  runtime error logs rather than standard help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/jingqing-hu/FuFiHLA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fufihla:0.2.3--hdfd78af_0
stdout: fufihla_fufihla-ref-prep.out
