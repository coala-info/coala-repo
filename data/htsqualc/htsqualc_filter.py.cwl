cwlVersion: v1.2
class: CommandLineTool
baseCommand: htsqualc_filter.py
label: htsqualc_filter.py
doc: "A tool for filtering HTS (High-Throughput Sequencing) data. (Note: The provided
  text contains system error messages regarding container execution and disk space,
  rather than the tool's help documentation. No arguments could be parsed from the
  input.)\n\nTool homepage: https://reneshbedre.github.io/blog/htseqqc.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htsqualc:1.1--pyhfa5458b_0
stdout: htsqualc_filter.py.out
