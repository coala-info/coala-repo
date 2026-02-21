cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenhll
label: krakenhll
doc: "KrakenHLL is a tool for metagenomic classification that combines the Kraken
  algorithm with HyperLogLog for efficient cardinality estimation. (Note: The provided
  text contains system error messages and does not include the tool's help documentation.)\n
  \nTool homepage: https://github.com/fbreitwieser/krakenhll"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
stdout: krakenhll.out
