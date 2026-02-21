cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-psmstatistics
label: proteomiqon-psmstatistics
doc: "A tool for calculating peptide-spectrum match (PSM) statistics. Note: The provided
  help text contains only system logs and error messages; no specific arguments could
  be parsed from the input.\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-psmstatistics:0.0.8--hdfd78af_0
stdout: proteomiqon-psmstatistics.out
