cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaquant
label: metaquant
doc: "Meta-analysis of quantitative proteomics data (Note: The provided text contains
  container runtime errors and does not include the tool's help documentation).\n\n
  Tool homepage: The package home page"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaquant:0.1.2--py35_0
stdout: metaquant.out
