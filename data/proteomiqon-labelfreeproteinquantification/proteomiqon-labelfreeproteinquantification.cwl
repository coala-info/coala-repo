cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-labelfreeproteinquantification
label: proteomiqon-labelfreeproteinquantification
doc: "A tool for label-free protein quantification. Note: The provided text appears
  to be a container engine error log rather than the tool's help documentation, so
  no arguments could be extracted.\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/proteomiqon-labelfreeproteinquantification:0.0.3--hdfd78af_1
stdout: proteomiqon-labelfreeproteinquantification.out
