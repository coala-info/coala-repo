cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-peptidespectrummatching
label: proteomiqon-peptidespectrummatching
doc: "A tool for peptide spectrum matching. (Note: The provided text is a container
  build error log and does not contain the help documentation or argument definitions
  for the tool.)\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-peptidespectrummatching:0.0.7--hdfd78af_1
stdout: proteomiqon-peptidespectrummatching.out
