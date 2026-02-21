cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cannoli
  - snpEff
label: cannoli_snpEff
doc: "The provided text contains system error logs related to a container build failure
  (no space left on device) rather than the help documentation for the tool. As a
  result, no arguments could be extracted.\n\nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_snpEff.out
