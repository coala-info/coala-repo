cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-peptidespectrummatching
label: proteomiqon-peptidespectrummatching_proteomiqon
doc: "A tool for peptide spectrum matching within the Proteomiqon suite. (Note: The
  provided text contained system error logs rather than help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-peptidespectrummatching:0.0.7--hdfd78af_1
stdout: proteomiqon-peptidespectrummatching_proteomiqon.out
