cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteomiqon-alignmentbasedquantification
label: proteomiqon-alignmentbasedquantification
doc: "A tool for alignment-based quantification in proteomics. Note: The provided
  help text contains only system logs and error messages; no specific arguments or
  usage details were available for extraction.\n\nTool homepage: https://csbiology.github.io/ProteomIQon/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteomiqon-alignmentbasedquantification:0.0.2--hdfd78af_0
stdout: proteomiqon-alignmentbasedquantification.out
