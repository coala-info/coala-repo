cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-joinquantpepionswithproteins
label: proteomiqon-joinquantpepionswithproteins
doc: "A tool for joining quantified peptide ions with proteins. (Note: The provided
  help text contained only system logs and an error message; no specific arguments
  or usage details were available in the input.)\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-joinquantpepionswithproteins:0.0.2--hdfd78af_1
stdout: proteomiqon-joinquantpepionswithproteins.out
