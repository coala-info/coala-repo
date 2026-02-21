cwlVersion: v1.2
class: CommandLineTool
baseCommand: npinv
label: npinv_npInv.jar
doc: "npInv is a tool for detecting structural variations, specifically inversions,
  from long-read sequencing data (such as Oxford Nanopore). Note: The provided text
  is an error log and does not contain argument specifications.\n\nTool homepage:
  https://github.com/haojingshao/npInv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/npinv:1.24--py27_0
stdout: npinv_npInv.jar.out
