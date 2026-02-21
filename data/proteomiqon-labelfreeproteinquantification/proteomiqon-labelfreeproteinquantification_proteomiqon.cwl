cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-labelfreeproteinquantification
label: proteomiqon-labelfreeproteinquantification_proteomiqon
doc: "A tool for label-free protein quantification, part of the ProteomIQon suite.\n
  \nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/proteomiqon-labelfreeproteinquantification:0.0.3--hdfd78af_1
stdout: proteomiqon-labelfreeproteinquantification_proteomiqon.out
