cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaquantome
label: metaquantome
doc: "A tool for quantitative metaproteomics data analysis. Note: The provided help
  text contains only system error messages regarding container execution and does
  not list specific command-line arguments.\n\nTool homepage: https://github.com/galaxyproteomics/metaquant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaquantome:2.0.2--pyhdfd78af_0
stdout: metaquantome.out
