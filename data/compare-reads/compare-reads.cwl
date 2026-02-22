cwlVersion: v1.2
class: CommandLineTool
baseCommand: compare-reads
label: compare-reads
doc: "A tool for comparing sequencing reads (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/mvdbeek/pysam-compare-reads"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/compare-reads:0.0.1--py310h1fe012e_2
stdout: compare-reads.out
