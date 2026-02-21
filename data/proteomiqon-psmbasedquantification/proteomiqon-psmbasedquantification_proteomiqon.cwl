cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-psmbasedquantification
label: proteomiqon-psmbasedquantification_proteomiqon
doc: "A tool for PSM-based quantification (Note: The provided help text contains only
  system error logs and no usage information).\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-psmbasedquantification:0.0.9--hdfd78af_0
stdout: proteomiqon-psmbasedquantification_proteomiqon.out
