cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - proteomiqon-peptidedb
label: proteomiqon-peptidedb_proteomiqon
doc: "A tool for peptide database generation. (Note: The provided input text is a
  container runtime error log and does not contain usage instructions or argument
  definitions.)\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-peptidedb:0.0.7--hdfd78af_1
stdout: proteomiqon-peptidedb_proteomiqon.out
