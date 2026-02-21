cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-proteininference
label: proteomiqon-proteininference_proteomiqon
doc: "A tool for protein inference within the Proteomiqon ecosystem.\n\nTool homepage:
  https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-proteininference:0.0.7--hdfd78af_1
stdout: proteomiqon-proteininference_proteomiqon.out
