cwlVersion: v1.2
class: CommandLineTool
baseCommand: mercat_mv
label: mercat_mv
doc: "A tool for Multi-Entity Relationship Clustering Analysis (Note: The provided
  text contains system error logs rather than help documentation, so specific arguments
  could not be extracted).\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mercat:0.2--py_1
stdout: mercat_mv.out
