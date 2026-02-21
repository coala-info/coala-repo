cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-peptidedb
label: proteomiqon-peptidedb
doc: "A tool for creating peptide databases for proteomic analysis.\n\nTool homepage:
  https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-peptidedb:0.0.7--hdfd78af_1
stdout: proteomiqon-peptidedb.out
