cwlVersion: v1.2
class: CommandLineTool
baseCommand: htsqualc
label: htsqualc
doc: "A tool for High-Throughput Sequencing (HTS) quality control. (Note: The provided
  text is a system error message regarding a container build failure and does not
  contain specific command-line argument definitions.)\n\nTool homepage: https://reneshbedre.github.io/blog/htseqqc.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htsqualc:1.1--pyhfa5458b_0
stdout: htsqualc.out
