cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-labeledproteinquantification
label: proteomiqon-labeledproteinquantification
doc: "A tool for labeled protein quantification. (Note: The provided text contained
  build logs rather than help documentation, so specific arguments could not be extracted.)\n
  \nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-labeledproteinquantification:0.0.3--hdfd78af_1
stdout: proteomiqon-labeledproteinquantification.out
