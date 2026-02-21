cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-proteininference
label: proteomiqon-proteininference
doc: "A tool for protein inference, part of the ProteomIQon proteomics toolbox. Note:
  The provided help text contains only container execution logs and does not list
  specific command-line arguments.\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-proteininference:0.0.7--hdfd78af_1
stdout: proteomiqon-proteininference.out
